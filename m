Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264F4EA428
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 02:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiC2AbY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiC2AbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 20:31:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCDA04C439;
        Mon, 28 Mar 2022 17:29:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41FCC20DEDEC;
        Mon, 28 Mar 2022 17:29:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41FCC20DEDEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648513780;
        bh=cGM0P3lImfAhuv+Yt4UwFeKiKEe0eNnM7spBmF6LXqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLCqGS7bPasQodPgsrNc/kytvUrvb18MQCmipexkF0LYdCpjuZylQfU7Z7rYlfKJn
         P1CYLza/TCs8WZ9j/7M2NyM29UtRFN1BFHO1+9X00cUT86mb5sU9/1AhD0pwFu+tyN
         38rAiS3gcN1TJSOEwbp5B3j84MiWqB2jmunxHKa4=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     mathieu.desnoyers@efficios.com
Cc:     beaub@microsoft.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org
Subject: Re: Comments on new user events ABI
Date:   Mon, 28 Mar 2022 17:29:35 -0700
Message-Id: <20220329002935.2869-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
References: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> ----- On Mar 28, 2022, at 4:24 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> Hi Beau, Hi Steven,
> 
> I've done a review of the trace events ABI, and I have a few comments.
> Sorry for being late to the party, but I only noticed this new ABI recently.
> Hopefully we can improve this ABI before the 5.18 release.
> 

Welcome to the party :)

> * user_events_status memory mapping
> 
> As I understand it, one part of the user events ABI is a memory mapping
> which contains "flags" which indicates whether a given event is enabled.
> It is indexed by byte, and each byte has this bitwise meaning:
> 
> /* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
> #define EVENT_BIT_FTRACE 0
> #define EVENT_BIT_PERF 1
> #define EVENT_BIT_OTHER 7
> 
> There are a few things I find odd here. First, to improve use of CPU cache,
> I would have expected this memory mapping to expose enable flags as a
> bitmap rather than an array of bytes, indexed bit-wise rather than byte-wise.
> I also don't get what user-space is expected to do differently if FTRACE vs
> PERF is enabled, considering that it gates a writev() to a file descriptor
> associated with /sys/kernel/debug/tracing/user_events_data.
> 

The intention wasn't for user-space to check the byte other than non-zero.
User processes could do that, but it's more so administration tools can see
where the events are registered if they cannot be closed and the state of the
machine.

Maybe you have a slicker way to do this, but it seems to check a bit in the
page would involve at least a byte read followed by a mask or shift? That
seems more expensive than checking a byte?

> I would have rather thought that tracers implemented in user-space could register
> themselves, and then there could be one /sys/kernel/debug/tracing/user_events_status
> per tracer. Considering that all kernel tracers use the same ABI to write an event,
> and then dispatch this event internally within the kernel to each registered
> tracer, I would expect to have a single memory mapping for all those (e.g. a
> /sys/kernel/debug/tracing/user_events_status/kernel_tracers file).
> 
> Then eventually if we have other user-space tracers such as lttng-ust with its
> their own user-space code performing tracing in a shared memory ring buffer, it
> would make sense to allow it to register its own
> /sys/kernel/debug/tracing/user_events_status/lttng_ust file, with its own indexes.
> 

I don't follow that. The intention is to get user processes to participate with
trace_events and the built-in tooling. When would a user-space tracer be used
instead of perf/ftrace?

It seems like a feature request?

> If this facility is ever used by lttng-ust to enable user-space tracing, I would not
> want to take the overhead of calling writev for the sake of kernel tracers if
> those are disabled.
> 

If they were disabled the byte wouldn't be set, right? So no writev overhead.

Seems I'm missing something.

> So perhaps in the short-term there is no need to implement the user-space tracer
> registration ABI, but I would have expected a simple bitmap for
> /sys/kernel/debug/tracing/user_events_data/kernel_tracers rather than the
> bytewise index, because as far as the kernel tracers are concerned, providing
> the bit to tell userspace instrumentation exactly which tracers are internally
> enabled within the kernel does not appear to be of any use other than increasing
> the footprint on the actively used cpu cache lines.
> 
> 
> * user_events_data page faults
> 
> If my understanding is correct, when the user-space program's memory containing
> the payload passed to writev() to a user_events_data file descriptor is kicked
> out from the page cache between fault_in_iov_iter_readable and its use by the
> tracers due to high memory pressure, the writev() will fail with -EFAULT and
> the data will be discarded unless user-space somehow handles this error (which
> is not handled in the samples/user_events/sample.c example program). It is good
> that the memory is faulted in immediately before calling the tracers, but
> considering that it is not mlock'd, should we make more effort to ensure the
> tracers are able to handle page faults ?
> 
> Integration of the work done by Michael Jeanson and myself on faultable tracepoint
> would allow the tracepoint probes to take page faults. Then, further modifications
> in the kernel tracers would be needed to handle those page faults.
> 

Is this something that can be done later or does it require ABI changes?

I would love to never miss data due to page faults.

> 
> * user_reg name_args and write_index vs purely user-space tracers
> 
> That part of the user event registration (event layout and ID allocation) appears
> to be intrinsically tied to the kernel tracers and the expected event layout. This
> seems fine as long as the only users we consider are the kernel tracers, but it
> appears to be less relevant for purely user-space tracers. Actually, tying the
> mmap'd event enable mechanism with the event ID and description makes me wonder
> whether it might be better to have LTTng-UST implement its own shared-memory based
> "fast-event-enabling" mechanism rather than use this user-event ABI. The other
> advantage of doing all of this in user-space would be to allow many instances
> of this bitmap to exist on a given system, e.g. one per container in a multi-container
> system, rather than requiring this to be a global kernel-wide singleton, and to use
> it from a non-privileged user.
> 

We have some conversation going about using namespaces/cgroups to isolation
containers with bitmaps/status pages. The main thing I personally want to be
able to do is from the root namespace see all the events in the descendents
easily via perf, eBPF or ftrace.

Link: https://lore.kernel.org/linux-trace-devel/20220316232009.7952988633787ef1003f13b0@kernel.org/

> 
> Some comments about the implementation:
> 
> kernel/trace/trace_events_user.c:
> static ssize_t user_events_write(struct file *file, const char __user *ubuf,
>                                  size_t count, loff_t *ppos)
> {
>         struct iovec iov;
>         struct iov_iter i;
> 
>         if (unlikely(*ppos != 0))
>                 return -EFAULT;
> 
>         if (unlikely(import_single_range(READ, (char *)ubuf, count, &iov, &i)))
>                 return -EFAULT;
>                                          ^ shouldn't this be "WRITE" ? This takes data from
>                                            user-space and copies it into the kernel, similarly
>                                            to fs/read_write.c:new_sync_write().

I think so, I mis-took the direction/rw flags for what the intention/protection
was. It appears the direction in this case is the direction of the user.

> 
>         return user_events_write_core(file, &i);
> }
> 
> include/uapi/linux/user_events.h:
> 
> struct user_reg {
> 
>         /* Input: Size of the user_reg structure being used */
>         __u32 size;
> 
>         /* Input: Pointer to string with event name, description and flags */
>         __u64 name_args;
> 
>         /* Output: Byte index of the event within the status page */
>         __u32 status_index;
> 
>         /* Output: Index of the event to use when writing data */
>         __u32 write_index;
> };
> 
> As this structure is expected to grow, and the user-space sample program uses "sizeof()"
> to figure out its size (which includes padding), I would be more comfortable if this was
> a packed structure rather than non-packed, because as fields are added, it's tricky to
> figure out from the kernel perspective whether the size received are fields that user-space
> is aware of, or if this is just padding.
> 

I think that would be a good idea, Steven?

> include/uapi/linux/user_events.h:
> 
> struct user_bpf_iter {
> 
>         /* Offset of the data within the first iovec */
>         __u32 iov_offset;
> 
>         /* Number of iovec structures */
>         __u32 nr_segs;
> 
>         /* Pointer to iovec structures */
>         const struct iovec *iov;
> 
>                            ^ a pointer in a uapi header is usually a no-go. This should be a u64.
> };
> 
> include/uapi/linux/user_events.h:
> 
> struct user_bpf_context {
> 
>         /* Data type being passed (see union below) */
>         __u32 data_type;
> 
>         /* Length of the data */
>         __u32 data_len;
> 
>         /* Pointer to data, varies by data type */
>         union {
>                 /* Kernel data (data_type == USER_BPF_DATA_KERNEL) */
>                 void *kdata;
> 
>                 /* User data (data_type == USER_BPF_DATA_USER) */
>                 void *udata;
> 
>                 /* Direct iovec (data_type == USER_BPF_DATA_ITER) */
>                 struct user_bpf_iter *iter;
> 
>                                ^ likewise for the 3 pointers above. Should be u64 in uapi headers.
>         };
> };
> 

The bpf structs are only used within a BPF program. At that point the pointer
sizes should all align, right?

I wanted to ensure libbpf type scenarios have easy access to the BPF argument
structures.

I guess I could move them to the kernel side, but then users would have to get
access to them for BPF programs.

> kernel/trace/trace_events_user.c:
> 
> static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
> {
>         u32 size;
>         long ret;
> 
>         ret = get_user(size, &ureg->size);
> 
>         if (ret)
>                 return ret;
> 
> 
>         if (size > PAGE_SIZE)
>                 return -E2BIG;
> 
>         ^ here I would be tempted to validate that the structure size at least provides room
>           for the "v0" ABI, e.g.:
> 
>              if (size < offsetofend(struct user_reg, write_index))
>                   return -EINVAL;
> 
>         return copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);
> 
>               ^ I find it odd that the kernel copy of struct user_reg may contain a
>                 size field which contents differs from the size fetched by get_user().
>                 This can happen if a buggy or plainly hostile user-space attempts to
>                 confuse the kernel about the size of this structure. Fortunately, the
>                 size field does not seem to be used afterwards, but I would think it
>                 safer to copy back the "size" fetched by get_user into the reg->size
>                 after copy_struct_from_user in case future changes in the code end up
>                 relying on a consistent size field.
> }
> 

Any size that the user doesn't fill in will zero out, if they enter a large
size then we error out. I tried to get the data out from the user once and use
it consistently from the kernel side. I didn't want users changing their values
at key places trying to get the kernel to do bad things.

This is why the size isn't used beyond the first copy (and why the data in the
write paths is only validated after paging in and copy the data to a buffer
that the user process no longer can modify mid-write).

> kernel/trace/trace_events_user.c:
> 
> static struct user_event *find_user_event(char *name, u32 *outkey)
> {
>         struct user_event *user;
>         u32 key = user_event_key(name);
> 
>         *outkey = key;
> 
>         hash_for_each_possible(register_table, user, node, key)
>                 if (!strcmp(EVENT_NAME(user), name)) {
>                         atomic_inc(&user->refcnt);
> 
>                         ^ what happens if an ill-intended user-space populates enough references
>                           to overflow refcnt (atomic_t). I suspect it can make the kernel free
>                           memory that is still in use, and trigger a use-after-free scenario.
>                           Usually reference counters should use include/linux/refcount.h which
>                           handles reference counter saturation. user_event_parse() has also a use
>                           of atomic_inc() on that same refcnt which userspace can overflow.
> 

This is a good catch. I'll look into refcount.h, thanks!

>                         return user;
>                 }
> 
>         return NULL;
> }
> 
> kernel/trace/trace_events_user.c:
> 
> static int user_events_release(struct inode *node, struct file *file)
> {
> [...]
>         /*
>          * Ensure refs cannot change under any situation by taking the
>          * register mutex during the final freeing of the references.
>          */
>         mutex_lock(&reg_mutex);
> [...]
>         mutex_unlock(&reg_mutex);
> 
>         kfree(refs);
> 
>         ^ AFAIU, the user_events_write() does not rely on reg_mutex to ensure mutual exclusion.
>           Doing so would be prohibitive performance-wise. But I suspect that freeing "refs" here
>           without waiting for a RCU grace period can be an issue if user_events_write_core is using
>           refs concurrently with file descriptor close.
> 

The refs is per-file, so if user_events_write() is running release cannot be
called for that file instance, since it's being used. Did I miss something?

> kernel/trace/trace_events_user.c:
> 
> static bool user_field_match(struct ftrace_event_field *field, int argc,
>                              const char **argv, int *iout)
> [...]
> 
>         for (; i < argc; ++i) {
> [...]
>                 pos += snprintf(arg_name + pos, len - pos, argv[i]);
> 
>         ^ what happens if strlen(argv[i]) > (len - pos) ? Based on lib/vsprintf.c:
> 
>  * The return value is the number of characters which would be
>  * generated for the given input, excluding the trailing null,
>  * as per ISO C99.  If the return is greater than or equal to
>  * @size, the resulting string is truncated.
> 
>         So the "pos" returned by the first call to sprintf would be greater than MAX_FIELD_ARG_NAME.
>         Then the second call to snprintf passes a @size argument of "len - pos" using the pos value
>         which is larger than len... which is a negative integer passed as argument to a size_t (unsigned).
>         So it expects a very long string. And the @buf argument is out-of-bound (field_name + pos).
>         Is this pattern for using snprintf() used elsewhere ? From a quick grep, I find this pattern in
>         a few places where AFAIU the input is not user-controlled (as it seems to be the case here), but
>         still it might be worth looking into:
> 
>              kernel/cgroup/cgroup.c:show_delegatable_files()
>              kernel/time/clocksource.c:available_clocksource_show()
> 
> Also, passing a copy of a userspace string (argv[i]) as format string argument to
> snprintf can be misused to leak kernel data to user-space.
> 
> The same function also appear to have similar issues with its use of the field->name userspace input
> string.
> 

The strings are copied first before coming down these paths, so they cannot
be forced to changed mid-reads, etc.

I think simply checking if any arg is beyond the MAX_FIELD_ARG_NAME would
prevent these types of issues, right?

> Unfortunately this is all the time I have for review right now, but it is at least a good starting
> point for discussion.
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

Thanks,
-Beau
