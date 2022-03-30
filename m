Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBFB4EBAD0
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiC3GdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Mar 2022 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiC3GdA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2022 02:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46656431;
        Tue, 29 Mar 2022 23:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52699616C3;
        Wed, 30 Mar 2022 06:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0DDC340EC;
        Wed, 30 Mar 2022 06:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648621874;
        bh=65x8jxunnWlKGQolcMnrPvWIBfk8CfZE3BJfWaU0rFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J6IJZ0QXTwdvlRFt6h6sHzVRZBkQhjrBNkqKWyn4hz8syhJPT8zcTIw3rQ2KOraRm
         0cTzNjP9OB99o6Ei/fY1OzQvNNvaUnl9/8ScUaKWTY2kFaExs87Ze10onHVQr+ZS5s
         IXpwaWjCl9OLfwd/C/Q0zBzGqbrv6v6tL7cvR7gTm7MqFMCfQ8vt4L9FrDHRwy9BKQ
         Dr5YhSBzJMisuiq7RGT+LkfJdfmSe7Ml8ri1QVMRMO+JNYouqroN6lzAHDBVAsYICz
         R8HOLuUov7eutQuOELHmkVJUNSUA2RkKUate8NC+YydwWOpf9pdPhWMlAN11z9nbMb
         o1QVyeNtG1sMw==
Date:   Wed, 30 Mar 2022 15:31:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Beau Belgrave <beaub@microsoft.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: Comments on new user events ABI
Message-Id: <20220330153110.10c3f2236b1cd5759f0b5c79@kernel.org>
In-Reply-To: <20220329215421.GA2997@kbox>
References: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
        <20220329002935.2869-1-beaub@linux.microsoft.com>
        <1014535694.197402.1648570634323.JavaMail.zimbra@efficios.com>
        <20220329215421.GA2997@kbox>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 29 Mar 2022 14:54:21 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Tue, Mar 29, 2022 at 12:17:14PM -0400, Mathieu Desnoyers wrote:
> > ----- On Mar 28, 2022, at 8:29 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> > 
> > >> ----- On Mar 28, 2022, at 4:24 PM, Mathieu Desnoyers
> > >> mathieu.desnoyers@efficios.com wrote:
> 
> [..]
> 
> > >> I also don't get what user-space is expected to do differently if FTRACE vs
> > >> PERF is enabled, considering that it gates a writev() to a file descriptor
> > >> associated with /sys/kernel/debug/tracing/user_events_data.
> > >> 
> > > 
> > > The intention wasn't for user-space to check the byte other than non-zero.
> > > User processes could do that, but it's more so administration tools can see
> > > where the events are registered if they cannot be closed and the state of the
> > > machine.
> > 
> > Administration tools could simply use a seqfile interface and parse text. I
> > don't expect those to be performance-sensitive at all. So we should not design
> > the overhead-sensitive mmap'd ABI (enable flags) for administration tools.
> > 
> > > Maybe you have a slicker way to do this, but it seems to check a bit in the
> > > page would involve at least a byte read followed by a mask or shift?
> > 
> > I suspect the minimum cost in terms of instruction would be to have the mask
> > prepared in advance (when the event is registered), and therefore the instructions
> > required on the user-space fast-path would be a load followed by a mask (&).
> > 
> > > That seems more expensive than checking a byte?
> > 
> > It is one single extra ALU instruction on the fast-path, indeed. But we have to
> > be careful about optimizing too much for a non-representative microbenchmark
> > and missing the big picture, which includes L1/L2 cache lines and TLB load overhead
> > when tracing a real-life workloads.
> > 
> > On modern x86 CPUs, an ALU instruction takes around 0.3ns, which is a few
> > orders of magnitude faster than a cache miss. Using bit-wise rather than
> > byte-wise indexing increases functional density of those enable flags by a
> > factor 8, which lessens the amount of cpu cache required by that same factor.
> > 
> > So as soon as the workload running on the system fills the CPU L1 or L2 caches,
> > when the number of user events registered scales up, and when the checks for
> > events enabled are done frequently enough, evicting fewer cache lines becomes
> > more important than the extra instruction required to apply the mask on the
> > fast-path.
> > 
> 
> Ok, makes sense. This will give us more events as well, something I hear
> some complaints about.
> 
> > > 
> > >> I would have rather thought that tracers implemented in user-space could
> > >> register
> > >> themselves, and then there could be one
> > >> /sys/kernel/debug/tracing/user_events_status
> > >> per tracer. Considering that all kernel tracers use the same ABI to write an
> > >> event,
> > >> and then dispatch this event internally within the kernel to each registered
> > >> tracer, I would expect to have a single memory mapping for all those (e.g. a
> > >> /sys/kernel/debug/tracing/user_events_status/kernel_tracers file).

I'm not sure you understand the meaning of per-event flag, but as far as I know
the reason of those per-event flags may be same reason of SDT semaphore. The event
which is NOT traced from kernel(via perf or via ftrace) needs to be skipped because
preparing the user-event arguments (e.g. getting a variable "name" in user-space
language runtime) may take a long time.

> > >> Then eventually if we have other user-space tracers such as lttng-ust with its
> > >> their own user-space code performing tracing in a shared memory ring buffer, it
> > >> would make sense to allow it to register its own
> > >> /sys/kernel/debug/tracing/user_events_status/lttng_ust file, with its own
> > >> indexes.
> > >> 
> > > 
> > > I don't follow that. The intention is to get user processes to participate with
> > > trace_events and the built-in tooling. When would a user-space tracer be used
> > > instead of perf/ftrace?
> > > 
> > > It seems like a feature request?
> > 
> > It can very well be out of scope for the user events, and I'm fine with that.
> > I was merely considering how the user events could be leveraged by tracers
> > implemented purely in user-space. But if the stated goal of this feature is
> > really to call into kernel tracers through a writev(), then I suspect that
> > supporting purely user-space tracers is indeed out of scope.
> > 
> 
> That was the goal with this ABI, are there maybe ways we can change the
> ABI to accomodate this later without shutting that out?

Beau, would you have any plan to make a tracer-tool application?
I thought this ABI is for adding "logger" like interface for perf/ftrace (or BPF,
that will be a long way).

> 
> > > 
> > >> If this facility is ever used by lttng-ust to enable user-space tracing, I would
> > >> not
> > >> want to take the overhead of calling writev for the sake of kernel tracers if
> > >> those are disabled.

I think this is totally different design with the lttng-ust, which collects event data
in user-space and kernel-space separately. Users will use them properly according
to the situation and purpose.

> > > If they were disabled the byte wouldn't be set, right? So no writev overhead.
> > > 
> > > Seems I'm missing something.
> > 
> > I was wondering whether we could leverage the user events bit-enable ABI for
> > tracers which are not implemented within the Linux kernel (e.g. LTTng-UST).
> > But I suspect it might be better for me to re-implement this in user-space
> > over shared memory.
> > 
> 
> Perhaps.

Sorry, I actually doubt it, since it relays on the user space program which
correctly works and write the event correct way (this is why I had asked you
to verify the event format at writev). Or perhaps we can verify it when merging
the shared pages...

> > > 
> > >> So perhaps in the short-term there is no need to implement the user-space tracer
> > >> registration ABI, but I would have expected a simple bitmap for
> > >> /sys/kernel/debug/tracing/user_events_data/kernel_tracers rather than the
> > >> bytewise index, because as far as the kernel tracers are concerned, providing
> > >> the bit to tell userspace instrumentation exactly which tracers are internally
> > >> enabled within the kernel does not appear to be of any use other than increasing
> > >> the footprint on the actively used cpu cache lines.

I agreed with this.

> > >> * user_events_data page faults
> > >> 
> > >> If my understanding is correct, when the user-space program's memory containing
> > >> the payload passed to writev() to a user_events_data file descriptor is kicked
> > >> out from the page cache between fault_in_iov_iter_readable and its use by the
> > >> tracers due to high memory pressure, the writev() will fail with -EFAULT and
> > >> the data will be discarded unless user-space somehow handles this error (which
> > >> is not handled in the samples/user_events/sample.c example program). It is good
> > >> that the memory is faulted in immediately before calling the tracers, but
> > >> considering that it is not mlock'd, should we make more effort to ensure the
> > >> tracers are able to handle page faults ?

I think this should be handled by user-space implementation (retry?).

> > >> Integration of the work done by Michael Jeanson and myself on faultable
> > >> tracepoint
> > >> would allow the tracepoint probes to take page faults. Then, further
> > >> modifications
> > >> in the kernel tracers would be needed to handle those page faults.

Interesting.

> > > Is this something that can be done later or does it require ABI changes?
> > > 
> > > I would love to never miss data due to page faults.
> > 
> > This is internal to the user events, tracepoint, and kernel tracers
> > implementation. I don't expect this to modify the user events ABI.
> > 
> > The only thing that might require some thinking ABI-wise is how the ring
> > buffers are exposed to user-space consumers, because we would want to
> > allow taking page faults between space reservation and commit.
> > 
> > The LTTng ring buffer has been supporting this out of the box for years
> > now, but this may be trickier for other kernel tracers, for which allowing
> > preemption between reserve and commit has never been a requirement until
> > now.
> > 
> 
> I'll let Steven comment on that one.
> 
> > > 
> > >> 
> > >> * user_reg name_args and write_index vs purely user-space tracers
> > >> 
> > >> That part of the user event registration (event layout and ID allocation)
> > >> appears
> > >> to be intrinsically tied to the kernel tracers and the expected event layout.
> > >> This
> > >> seems fine as long as the only users we consider are the kernel tracers, but it
> > >> appears to be less relevant for purely user-space tracers. Actually, tying the
> > >> mmap'd event enable mechanism with the event ID and description makes me wonder
> > >> whether it might be better to have LTTng-UST implement its own shared-memory
> > >> based
> > >> "fast-event-enabling" mechanism rather than use this user-event ABI. The other
> > >> advantage of doing all of this in user-space would be to allow many instances
> > >> of this bitmap to exist on a given system, e.g. one per container in a
> > >> multi-container
> > >> system, rather than requiring this to be a global kernel-wide singleton, and to
> > >> use
> > >> it from a non-privileged user.
> > >> 
> > > 
> > > We have some conversation going about using namespaces/cgroups to isolation
> > > containers with bitmaps/status pages. The main thing I personally want to be
> > > able to do is from the root namespace see all the events in the descendents
> > > easily via perf, eBPF or ftrace.
> > > 
> > > Link:
> > > https://lore.kernel.org/linux-trace-devel/20220316232009.7952988633787ef1003f13b0@kernel.org/
> > > 
> > 
> > I see that a notion close to "tracing namespaces" comes up in this thread. This is something
> > I brought forward at the last Linux Plumbers Conference aiming to facilitate system call tracing
> > for a given container (or from a process hierarchy). I suspect the tracing namespace could also
> > be tied to a set of kernel buffers, and to a user events "domain". I think this concept could
> > neatly solve many of our container-related isolation issues here. As you say, it should probably
> > be a hierarchical namespace.
> > 
> 
> Agreed.

Great :-)

> > >> Some comments about the implementation:
> > [...]
> > > 
> > >> 
> > >>         return user_events_write_core(file, &i);
> > >> }
> > >> 
> > >> include/uapi/linux/user_events.h:
> > >> 
> > >> struct user_reg {
> > >> 
> > >>         /* Input: Size of the user_reg structure being used */
> > >>         __u32 size;
> > >> 
> > >>         /* Input: Pointer to string with event name, description and flags */
> > >>         __u64 name_args;
> > >> 
> > >>         /* Output: Byte index of the event within the status page */
> > >>         __u32 status_index;
> > >> 
> > >>         /* Output: Index of the event to use when writing data */
> > >>         __u32 write_index;
> > >> };
> > >> 
> > >> As this structure is expected to grow, and the user-space sample program uses
> > >> "sizeof()"
> > >> to figure out its size (which includes padding), I would be more comfortable if
> > >> this was
> > >> a packed structure rather than non-packed, because as fields are added, it's
> > >> tricky to
> > >> figure out from the kernel perspective whether the size received are fields that
> > >> user-space
> > >> is aware of, or if this is just padding.


Indeed, any user-space exposed structure should be packed or correctly aligned,
because those can be built on many architectures.


Thank you,

> > >> 
> > > 
> > > I think that would be a good idea, Steven?
> > 
> > [leaving this for Steven to answer]
> > 
>

-- 
Masami Hiramatsu <mhiramat@kernel.org>
