Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0515A4EB579
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiC2V4O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiC2V4N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 17:56:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF95F7D016;
        Tue, 29 Mar 2022 14:54:27 -0700 (PDT)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4235D20DEDDC;
        Tue, 29 Mar 2022 14:54:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4235D20DEDDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648590867;
        bh=mW0bo5v5l1/kvbvfVIpkKA3M1It2YE+RTpQOO0FT99A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lB2EIc03WMqNY2E3jnpEa/4mukvD7QFo0sGz9a0fh5anSMF1/OvS+/6cVKsomfYhH
         RA63aq39hsA9UZQYnvipGQESJuMQDQ0ecHIz+FNg3xTgevKupGAG8X6PH8/oojwvH5
         fcWQlrPzxlRZkmjI2po5wnXpdeyLiTh5AnCLBm2I=
Date:   Tue, 29 Mar 2022 14:54:21 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Beau Belgrave <beaub@microsoft.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: Comments on new user events ABI
Message-ID: <20220329215421.GA2997@kbox>
References: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
 <20220329002935.2869-1-beaub@linux.microsoft.com>
 <1014535694.197402.1648570634323.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014535694.197402.1648570634323.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 29, 2022 at 12:17:14PM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 28, 2022, at 8:29 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> 
> >> ----- On Mar 28, 2022, at 4:24 PM, Mathieu Desnoyers
> >> mathieu.desnoyers@efficios.com wrote:

[..]

> >> I also don't get what user-space is expected to do differently if FTRACE vs
> >> PERF is enabled, considering that it gates a writev() to a file descriptor
> >> associated with /sys/kernel/debug/tracing/user_events_data.
> >> 
> > 
> > The intention wasn't for user-space to check the byte other than non-zero.
> > User processes could do that, but it's more so administration tools can see
> > where the events are registered if they cannot be closed and the state of the
> > machine.
> 
> Administration tools could simply use a seqfile interface and parse text. I
> don't expect those to be performance-sensitive at all. So we should not design
> the overhead-sensitive mmap'd ABI (enable flags) for administration tools.
> 
> > Maybe you have a slicker way to do this, but it seems to check a bit in the
> > page would involve at least a byte read followed by a mask or shift?
> 
> I suspect the minimum cost in terms of instruction would be to have the mask
> prepared in advance (when the event is registered), and therefore the instructions
> required on the user-space fast-path would be a load followed by a mask (&).
> 
> > That seems more expensive than checking a byte?
> 
> It is one single extra ALU instruction on the fast-path, indeed. But we have to
> be careful about optimizing too much for a non-representative microbenchmark
> and missing the big picture, which includes L1/L2 cache lines and TLB load overhead
> when tracing a real-life workloads.
> 
> On modern x86 CPUs, an ALU instruction takes around 0.3ns, which is a few
> orders of magnitude faster than a cache miss. Using bit-wise rather than
> byte-wise indexing increases functional density of those enable flags by a
> factor 8, which lessens the amount of cpu cache required by that same factor.
> 
> So as soon as the workload running on the system fills the CPU L1 or L2 caches,
> when the number of user events registered scales up, and when the checks for
> events enabled are done frequently enough, evicting fewer cache lines becomes
> more important than the extra instruction required to apply the mask on the
> fast-path.
> 

Ok, makes sense. This will give us more events as well, something I hear
some complaints about.

> > 
> >> I would have rather thought that tracers implemented in user-space could
> >> register
> >> themselves, and then there could be one
> >> /sys/kernel/debug/tracing/user_events_status
> >> per tracer. Considering that all kernel tracers use the same ABI to write an
> >> event,
> >> and then dispatch this event internally within the kernel to each registered
> >> tracer, I would expect to have a single memory mapping for all those (e.g. a
> >> /sys/kernel/debug/tracing/user_events_status/kernel_tracers file).
> >> 
> >> Then eventually if we have other user-space tracers such as lttng-ust with its
> >> their own user-space code performing tracing in a shared memory ring buffer, it
> >> would make sense to allow it to register its own
> >> /sys/kernel/debug/tracing/user_events_status/lttng_ust file, with its own
> >> indexes.
> >> 
> > 
> > I don't follow that. The intention is to get user processes to participate with
> > trace_events and the built-in tooling. When would a user-space tracer be used
> > instead of perf/ftrace?
> > 
> > It seems like a feature request?
> 
> It can very well be out of scope for the user events, and I'm fine with that.
> I was merely considering how the user events could be leveraged by tracers
> implemented purely in user-space. But if the stated goal of this feature is
> really to call into kernel tracers through a writev(), then I suspect that
> supporting purely user-space tracers is indeed out of scope.
> 

That was the goal with this ABI, are there maybe ways we can change the
ABI to accomodate this later without shutting that out?

> > 
> >> If this facility is ever used by lttng-ust to enable user-space tracing, I would
> >> not
> >> want to take the overhead of calling writev for the sake of kernel tracers if
> >> those are disabled.
> >> 
> > 
> > If they were disabled the byte wouldn't be set, right? So no writev overhead.
> > 
> > Seems I'm missing something.
> 
> I was wondering whether we could leverage the user events bit-enable ABI for
> tracers which are not implemented within the Linux kernel (e.g. LTTng-UST).
> But I suspect it might be better for me to re-implement this in user-space
> over shared memory.
> 

Perhaps.

> > 
> >> So perhaps in the short-term there is no need to implement the user-space tracer
> >> registration ABI, but I would have expected a simple bitmap for
> >> /sys/kernel/debug/tracing/user_events_data/kernel_tracers rather than the
> >> bytewise index, because as far as the kernel tracers are concerned, providing
> >> the bit to tell userspace instrumentation exactly which tracers are internally
> >> enabled within the kernel does not appear to be of any use other than increasing
> >> the footprint on the actively used cpu cache lines.
> >> 
> >> 
> >> * user_events_data page faults
> >> 
> >> If my understanding is correct, when the user-space program's memory containing
> >> the payload passed to writev() to a user_events_data file descriptor is kicked
> >> out from the page cache between fault_in_iov_iter_readable and its use by the
> >> tracers due to high memory pressure, the writev() will fail with -EFAULT and
> >> the data will be discarded unless user-space somehow handles this error (which
> >> is not handled in the samples/user_events/sample.c example program). It is good
> >> that the memory is faulted in immediately before calling the tracers, but
> >> considering that it is not mlock'd, should we make more effort to ensure the
> >> tracers are able to handle page faults ?
> >> 
> >> Integration of the work done by Michael Jeanson and myself on faultable
> >> tracepoint
> >> would allow the tracepoint probes to take page faults. Then, further
> >> modifications
> >> in the kernel tracers would be needed to handle those page faults.
> >> 
> > 
> > Is this something that can be done later or does it require ABI changes?
> > 
> > I would love to never miss data due to page faults.
> 
> This is internal to the user events, tracepoint, and kernel tracers
> implementation. I don't expect this to modify the user events ABI.
> 
> The only thing that might require some thinking ABI-wise is how the ring
> buffers are exposed to user-space consumers, because we would want to
> allow taking page faults between space reservation and commit.
> 
> The LTTng ring buffer has been supporting this out of the box for years
> now, but this may be trickier for other kernel tracers, for which allowing
> preemption between reserve and commit has never been a requirement until
> now.
> 

I'll let Steven comment on that one.

> > 
> >> 
> >> * user_reg name_args and write_index vs purely user-space tracers
> >> 
> >> That part of the user event registration (event layout and ID allocation)
> >> appears
> >> to be intrinsically tied to the kernel tracers and the expected event layout.
> >> This
> >> seems fine as long as the only users we consider are the kernel tracers, but it
> >> appears to be less relevant for purely user-space tracers. Actually, tying the
> >> mmap'd event enable mechanism with the event ID and description makes me wonder
> >> whether it might be better to have LTTng-UST implement its own shared-memory
> >> based
> >> "fast-event-enabling" mechanism rather than use this user-event ABI. The other
> >> advantage of doing all of this in user-space would be to allow many instances
> >> of this bitmap to exist on a given system, e.g. one per container in a
> >> multi-container
> >> system, rather than requiring this to be a global kernel-wide singleton, and to
> >> use
> >> it from a non-privileged user.
> >> 
> > 
> > We have some conversation going about using namespaces/cgroups to isolation
> > containers with bitmaps/status pages. The main thing I personally want to be
> > able to do is from the root namespace see all the events in the descendents
> > easily via perf, eBPF or ftrace.
> > 
> > Link:
> > https://lore.kernel.org/linux-trace-devel/20220316232009.7952988633787ef1003f13b0@kernel.org/
> > 
> 
> I see that a notion close to "tracing namespaces" comes up in this thread. This is something
> I brought forward at the last Linux Plumbers Conference aiming to facilitate system call tracing
> for a given container (or from a process hierarchy). I suspect the tracing namespace could also
> be tied to a set of kernel buffers, and to a user events "domain". I think this concept could
> neatly solve many of our container-related isolation issues here. As you say, it should probably
> be a hierarchical namespace.
> 

Agreed.

> >> 
> >> Some comments about the implementation:
> [...]
> > 
> >> 
> >>         return user_events_write_core(file, &i);
> >> }
> >> 
> >> include/uapi/linux/user_events.h:
> >> 
> >> struct user_reg {
> >> 
> >>         /* Input: Size of the user_reg structure being used */
> >>         __u32 size;
> >> 
> >>         /* Input: Pointer to string with event name, description and flags */
> >>         __u64 name_args;
> >> 
> >>         /* Output: Byte index of the event within the status page */
> >>         __u32 status_index;
> >> 
> >>         /* Output: Index of the event to use when writing data */
> >>         __u32 write_index;
> >> };
> >> 
> >> As this structure is expected to grow, and the user-space sample program uses
> >> "sizeof()"
> >> to figure out its size (which includes padding), I would be more comfortable if
> >> this was
> >> a packed structure rather than non-packed, because as fields are added, it's
> >> tricky to
> >> figure out from the kernel perspective whether the size received are fields that
> >> user-space
> >> is aware of, or if this is just padding.
> >> 
> > 
> > I think that would be a good idea, Steven?
> 
> [leaving this for Steven to answer]
> 

[..]

> >> kernel/trace/trace_events_user.c:
> >> 
> >> static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
> >> {
> >>         u32 size;
> >>         long ret;
> >> 
> >>         ret = get_user(size, &ureg->size);
> >> 
> >>         if (ret)
> >>                 return ret;
> >> 
> >> 
> >>         if (size > PAGE_SIZE)
> >>                 return -E2BIG;
> >> 
> >>         ^ here I would be tempted to validate that the structure size at least provides
> >>         room
> >>           for the "v0" ABI, e.g.:
> >> 
> >>              if (size < offsetofend(struct user_reg, write_index))
> >>                   return -EINVAL;
> >> 
> >>         return copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);
> >> 
> >>               ^ I find it odd that the kernel copy of struct user_reg may contain a
> >>                 size field which contents differs from the size fetched by get_user().
> >>                 This can happen if a buggy or plainly hostile user-space attempts to
> >>                 confuse the kernel about the size of this structure. Fortunately, the
> >>                 size field does not seem to be used afterwards, but I would think it
> >>                 safer to copy back the "size" fetched by get_user into the reg->size
> >>                 after copy_struct_from_user in case future changes in the code end up
> >>                 relying on a consistent size field.
> >> }
> >> 
> > 
> > Any size that the user doesn't fill in will zero out, if they enter a large
> > size then we error out. I tried to get the data out from the user once and use
> > it consistently from the kernel side. I didn't want users changing their values
> > at key places trying to get the kernel to do bad things.
> > 
> > This is why the size isn't used beyond the first copy (and why the data in the
> > write paths is only validated after paging in and copy the data to a buffer
> > that the user process no longer can modify mid-write).
> 
> As long as the kreg->size value is not used afterwards, it's technically fine, but
> having it there and inconsistent with the size value loaded by get_user() is error-prone.
> I would recommend to either overwrite this kreg->size value with the size loaded by
> get_user(), or document that this field should never be used because it is inconsistent
> with the size used for copy_struct_from_user().
> 

Alright, I'll set it afterwards.

> [...]
> 
> >> kernel/trace/trace_events_user.c:
> >> 
> >> static int user_events_release(struct inode *node, struct file *file)
> >> {
> >> [...]
> >>         /*
> >>          * Ensure refs cannot change under any situation by taking the
> >>          * register mutex during the final freeing of the references.
> >>          */
> >>         mutex_lock(&reg_mutex);
> >> [...]
> >>         mutex_unlock(&reg_mutex);
> >> 
> >>         kfree(refs);
> >> 
> >>         ^ AFAIU, the user_events_write() does not rely on reg_mutex to ensure mutual
> >>         exclusion.
> >>           Doing so would be prohibitive performance-wise. But I suspect that freeing
> >>           "refs" here
> >>           without waiting for a RCU grace period can be an issue if user_events_write_core
> >>           is using
> >>           refs concurrently with file descriptor close.
> >> 
> > 
> > The refs is per-file, so if user_events_write() is running release cannot be
> > called for that file instance, since it's being used. Did I miss something?
> 
> I'm possibly the one missing something here, but what prevents 2 threads
> from doing user_event_write() and close() concurrently on the same file descriptor ?
> 

While nothing prevents it, my understanding is that the actual release()
on the file_operations won't be invoked until the file struct has been
ref'd down to zero. (fs/file_table.c:fput, fs/read_write.c:do_pwritev).

While the write call is being run, the file should have a non-zero ref
count. I believe looking at do_pwritev the fdget/fdput pair are largely
responsible for this, do you agree?

> > 
> >> kernel/trace/trace_events_user.c:
> >> 
> >> static bool user_field_match(struct ftrace_event_field *field, int argc,
> >>                              const char **argv, int *iout)
> >> [...]
> >> 
> >>         for (; i < argc; ++i) {
> >> [...]
> >>                 pos += snprintf(arg_name + pos, len - pos, argv[i]);
> >> 
> >>         ^ what happens if strlen(argv[i]) > (len - pos) ? Based on lib/vsprintf.c:
> >> 
> >>  * The return value is the number of characters which would be
> >>  * generated for the given input, excluding the trailing null,
> >>  * as per ISO C99.  If the return is greater than or equal to
> >>  * @size, the resulting string is truncated.
> >> 
> >>         So the "pos" returned by the first call to sprintf would be greater than
> >>         MAX_FIELD_ARG_NAME.
> >>         Then the second call to snprintf passes a @size argument of "len - pos" using
> >>         the pos value
> >>         which is larger than len... which is a negative integer passed as argument to a
> >>         size_t (unsigned).
> >>         So it expects a very long string. And the @buf argument is out-of-bound
> >>         (field_name + pos).
> >>         Is this pattern for using snprintf() used elsewhere ? From a quick grep, I find
> >>         this pattern in
> >>         a few places where AFAIU the input is not user-controlled (as it seems to be the
> >>         case here), but
> >>         still it might be worth looking into:
> >> 
> >>              kernel/cgroup/cgroup.c:show_delegatable_files()
> >>              kernel/time/clocksource.c:available_clocksource_show()
> >> 
> >> Also, passing a copy of a userspace string (argv[i]) as format string argument
> >> to
> >> snprintf can be misused to leak kernel data to user-space.
> >> 
> >> The same function also appear to have similar issues with its use of the
> >> field->name userspace input
> >> string.
> >> 
> > 
> > The strings are copied first before coming down these paths, so they cannot
> > be forced to changed mid-reads, etc.
> 
> That's correct. But their combined length can be larger than MAX_FIELD_ARG_NAME.
> 
> > I think simply checking if any arg is beyond the MAX_FIELD_ARG_NAME would
> > prevent these types of issues, right?
> 
> No. The issue is when the combined length is larger than the max. If I look at
> other tracing code, I notice that it often uses a pattern where snprintf is first
> called on the input with a @size=0 to calculate the string length, then the
> output string is dynamically allocated with the correct length, and the entire
> code performing the snprintf formatting is called again with a nonzero size,
> thus effectively populating the output string. There are other ways to prevent
> these issues, but I would be tempted to use the same pattern used elsewhere in
> the tracing code. See trace_events_user.c:user_event_set_print_fmt() as an example.
> 
> And don't forget that passing a copy of a user input as snprintf format string is
> bad, because it allows user-space to provide event/fields names with e.g. "%s" or
> "%p" and control the behavior of snprintf in unwanted ways, typically leading to
> a kernel memory information leak to user-space.
> 

Yes, agreed. I will address this.

> Thanks,
> 
> Mathieu
> 
> > 
> >> Unfortunately this is all the time I have for review right now, but it is at
> >> least a good starting
> >> point for discussion.
> >> 
> >> Thanks,
> >> 
> >> Mathieu
> >> 
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> > 
> > Thanks,
> > -Beau
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

Thanks,
-Beau
