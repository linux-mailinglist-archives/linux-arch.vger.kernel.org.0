Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5E48705E
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 03:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiAGC2B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 21:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbiAGC17 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 21:27:59 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7DFC061245;
        Thu,  6 Jan 2022 18:27:58 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5eyw-000FOn-Nz; Fri, 07 Jan 2022 02:27:54 +0000
Date:   Fri, 7 Jan 2022 02:27:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 06/10] exit: Implement kthread_exit
Message-ID: <YdelKq9U86/dHPcm@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-6-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:28PM -0600, Eric W. Biederman wrote:

> +/**
> + * kthread_exit - Cause the current kthread return @result to kthread_stop().
> + * @result: The integer value to return to kthread_stop().
> + *
> + * While kthread_exit can be called directly, it exists so that
> + * functions which do some additional work in non-modular code such as
> + * module_put_and_kthread_exit can be implemented.
> + *
> + * Does not return.
> + */
> +void __noreturn kthread_exit(long result)
> +{
> +	do_exit(result);
> +}

>  static int kthread(void *_create)
>  {
>  	static const struct sched_param param = { .sched_priority = 0 };
> @@ -286,13 +301,13 @@ static int kthread(void *_create)
>  	done = xchg(&create->done, NULL);
>  	if (!done) {
>  		kfree(create);
> -		do_exit(-EINTR);
> +		kthread_exit(-EINTR);

This do_exit(-EINTR) is pure cargo-culting; nobody will see that return
value, since by this point nobody could have looked at the task_struct
or pid.  Look: we must have had
	* __kthread_create_on_node() called
	  it has allocated a request (create), filled it, put it on
	  kthreadd's request list and woke kthreadd up.
	* it went to wait (killably) for completion of create->done.
	* it got a SIGKILL and had succefully replaced create->done
	  with NULL.
	* since it has gotten non-NULL, it has buggered off (with -EINTR,
	  incidentally).
In the meanwhile, kthreadd had picked the request from its list and
successfully forked the child.  Child had run kthread() up to the point
you'd quoted, i.e. it had observed create->done already NULL, freed create
and is now terminating itself.

Caller of kernel_thread() doesn't pass the pid to anyone, since the pid
must've been positive.	kthread() does not store its pid or task_struct
reference anywhere on that path.  __kthread_create_on_node() doesn't even
bother looking at anything other than create->done and it returns -EINTR.
Child couldn't be traced by anyone.

So how the hell could anyone look at the value we pass to do_exit() here?
Might as well use do_exit(0)...


>  	if (!self) {
>  		create->result = ERR_PTR(-ENOMEM);
>  		complete(done);
> -		do_exit(-ENOMEM);
> +		kthread_exit(-ENOMEM);

Ditto.  We must have had
        * __kthread_create_on_node() called
	  it has allocated a request (create), filled it, put it on
	  kthreadd's request list and woke kthreadd.
	* it went to wait (killably) for completion of create->done.
	* it did *NOT* get SIGKILL until after kthread() the child
          successfully forked by kthreadd got through that xchg()
	  in kthread().
Either __kthread_create_on_node() hadn't gotten SIGKILL before our call
of complete(), or it has gotten one, observed NULL create->done and simply
proceeded to do wait_for_completion() on the same thing (it's its local
variable, so it knows what create->done used to point to).  Either way,
__kthread_create_on_node() hits
        task = create->result;
sees that it's ERR_PTR(-ENOMEM) and proceeds to fail with -ENOMEM.
Again, nothing is looking at the pid or task_struct of the child and
nothing could possibly observe its exit code.

>  	}
>  
>  	self->threadfn = threadfn;
> @@ -326,7 +341,7 @@ static int kthread(void *_create)
>  		__kthread_parkme(self);
>  		ret = threadfn(data);
>  	}
> -	do_exit(ret);
> +	kthread_exit(ret);

This one, OTOH, is a different story.  Here we have already hit the
completion and stopped the child.  With __kthread_create_on_node()
having found and returned the task_struct of the child.  Since that
point, somebody had already woken the child (using the pointer returned
by __kthread_create_on_node()).

What's more, the child's payload has already run to completion.
*NORMALLY* that means kthread_stop() called on it.  And there we do the
following bit of nastiness:
        get_task_struct(k);
	...
	mark it "should stop" and wake it up
	...
        wait_for_completion(&kthread->exited);
	ret = k->exit_code;
	put_task_struct(k);

kthread->exited is what k->vfork_done is left pointing to, so this
wait_for_completion() waits for that do_exit() in the kthread() and
we proceed to pick k->exit_code (using the fact that k has just
been pinned by us).  Then kthread_stop() proceeds to return that
value.

Pardon me while I puke.  The value being returned has nothing to do
with the things one could normally find in ->exit_code, for starters.
What's more, kthread->exited is a part of per-thread data structure,
and that same structure could bloody well be used to pass the damn
return value of threadfn(), instead of doing unnatural things with
->exit_code.  And that data structure is not freed until free_task(k),
i.e. we can fetch from it whenever we can fetch k->exit_code.

Oh, and all other ways to stop the thread do not bother looking at
the exit code at all.

IMO the right way to handle that would be
	1) turn these two do_exit() into do_exit(0), to reduce
confusion
	2) deal with all do_exit() in kthread payloads.  Your
name for the primitive is fine, IMO.
	3) make that primitive pass the return value by way of
a field in struct kthread, adjusting kthread_stop() accordingly
and passing 0 to do_exit() in kthread_exit() itself.

(2) is not as trivial as you seem to hope, though.  Your patches
in drivers/staging/rt*/ had papered over the problem in there,
but hadn't really solved it.

thread_exit() should've been shot, all right, but it really ought
to have been complete_and_exit() there.  The thing is, complete()
+ return does *not* guarantee that driver won't get unloaded before
the thread terminates.  Possibly freeing its .code and leaving
a thread to resume running in there as soon as it regains CPU.

The point of complete_and_exit() is that it's noreturn *and* in
core kernel.  So it can be safely used in a modular kthread,
if paired with wait_for_completion() in or before module_exit.
complete() + do_exit() (or complete + return as you've gotten
there) doesn't give such guarantees at all.

I'm (re)crawling through that zoo right now, will post when
I get more details.
