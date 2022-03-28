Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C74EA172
	for <lists+linux-arch@lfdr.de>; Mon, 28 Mar 2022 22:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbiC1U0d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbiC1U0c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 16:26:32 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ADD4C7BF;
        Mon, 28 Mar 2022 13:24:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BF6EA3FBAEC;
        Mon, 28 Mar 2022 16:24:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bVmQYq65rfRG; Mon, 28 Mar 2022 16:24:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F41653FBB70;
        Mon, 28 Mar 2022 16:24:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F41653FBB70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1648499089;
        bh=qFoG3MHJSaqcwKtqXG7+32spYi5VLkmmpF/B27Ny7ik=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Ld/x4Nb90cdD+0zLqLErS9XIWl82prheiLvk9w2bWJ6u6rpSEY5ViMRwPsOUtaK3t
         CX8Mvf6ZouBoJldnYOTUdjMvIcf/RqhGLWPkHcc2NClXzNfOTO7aqDqKx5P+rNmA+k
         vjp1Qfm5rmK1bW48lgWMTmhdP7Ez4pGVaIpTACJNNPKgxyq/59LLdwSZLvqfITKCG5
         ZL5cXeb+oaQ1EoIsxSJ8dH+HvinmoY8+SGLKKUZShcanoK1nNVwLyRpsrLnV8M+CeG
         vSz2FkfMna0kpoDxBZBN2RT1DjMWv2vc7YsofHJXYOT0a3IEQxBvUfk2hOQng1/eaq
         voFow7P4L9vWQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I28OI4v_5YmZ; Mon, 28 Mar 2022 16:24:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DBEA13FBEA7;
        Mon, 28 Mar 2022 16:24:48 -0400 (EDT)
Date:   Mon, 28 Mar 2022 16:24:48 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@microsoft.com>, rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
Subject: Comments on new user events ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Index: B0M+BmOcIucczO4F1K4t0lJIcDaNNQ==
Thread-Topic: Comments on new user events ABI
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Beau, Hi Steven,

I've done a review of the trace events ABI, and I have a few comments.
Sorry for being late to the party, but I only noticed this new ABI recently.
Hopefully we can improve this ABI before the 5.18 release.

A bit of context: as you know, I maintain LTTng-UST, a user-space Linux
tracer. It does not implement much in the kernel because its goal is to
be purely user-space, mainly for performance reasons. However, when there
are relevant kernel facilities it can use, or if I need to extend the
kernel to expose a generally useful ABI to user-space, I do it. For
instance, I've contributed the rseq() system call for the sake of speeding
up the LTTng-UST ring buffer and sched_getcpu(). The work I am currently
doing on virtual-cpu-ids is also with a primary goal of improving the
LTTng-UST ring buffers (and all memory allocators as a side-effect) ;) .
Hopefully we can work together and make sure the new ABIs are useful to
everyone.


* user_events_status memory mapping

As I understand it, one part of the user events ABI is a memory mapping
which contains "flags" which indicates whether a given event is enabled.
It is indexed by byte, and each byte has this bitwise meaning:

/* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
#define EVENT_BIT_FTRACE 0
#define EVENT_BIT_PERF 1
#define EVENT_BIT_OTHER 7

There are a few things I find odd here. First, to improve use of CPU cache,
I would have expected this memory mapping to expose enable flags as a
bitmap rather than an array of bytes, indexed bit-wise rather than byte-wise.
I also don't get what user-space is expected to do differently if FTRACE vs
PERF is enabled, considering that it gates a writev() to a file descriptor
associated with /sys/kernel/debug/tracing/user_events_data.

I would have rather thought that tracers implemented in user-space could register
themselves, and then there could be one /sys/kernel/debug/tracing/user_events_status
per tracer. Considering that all kernel tracers use the same ABI to write an event,
and then dispatch this event internally within the kernel to each registered
tracer, I would expect to have a single memory mapping for all those (e.g. a
/sys/kernel/debug/tracing/user_events_status/kernel_tracers file).

Then eventually if we have other user-space tracers such as lttng-ust with its
their own user-space code performing tracing in a shared memory ring buffer, it
would make sense to allow it to register its own
/sys/kernel/debug/tracing/user_events_status/lttng_ust file, with its own indexes.

If this facility is ever used by lttng-ust to enable user-space tracing, I would not
want to take the overhead of calling writev for the sake of kernel tracers if
those are disabled.

So perhaps in the short-term there is no need to implement the user-space tracer
registration ABI, but I would have expected a simple bitmap for
/sys/kernel/debug/tracing/user_events_data/kernel_tracers rather than the
bytewise index, because as far as the kernel tracers are concerned, providing
the bit to tell userspace instrumentation exactly which tracers are internally
enabled within the kernel does not appear to be of any use other than increasing
the footprint on the actively used cpu cache lines.


* user_events_data page faults

If my understanding is correct, when the user-space program's memory containing
the payload passed to writev() to a user_events_data file descriptor is kicked
out from the page cache between fault_in_iov_iter_readable and its use by the
tracers due to high memory pressure, the writev() will fail with -EFAULT and
the data will be discarded unless user-space somehow handles this error (which
is not handled in the samples/user_events/sample.c example program). It is good
that the memory is faulted in immediately before calling the tracers, but
considering that it is not mlock'd, should we make more effort to ensure the
tracers are able to handle page faults ?

Integration of the work done by Michael Jeanson and myself on faultable tracepoint
would allow the tracepoint probes to take page faults. Then, further modifications
in the kernel tracers would be needed to handle those page faults.


* user_reg name_args and write_index vs purely user-space tracers

That part of the user event registration (event layout and ID allocation) appears
to be intrinsically tied to the kernel tracers and the expected event layout. This
seems fine as long as the only users we consider are the kernel tracers, but it
appears to be less relevant for purely user-space tracers. Actually, tying the
mmap'd event enable mechanism with the event ID and description makes me wonder
whether it might be better to have LTTng-UST implement its own shared-memory based
"fast-event-enabling" mechanism rather than use this user-event ABI. The other
advantage of doing all of this in user-space would be to allow many instances
of this bitmap to exist on a given system, e.g. one per container in a multi-container
system, rather than requiring this to be a global kernel-wide singleton, and to use
it from a non-privileged user.


Some comments about the implementation:

kernel/trace/trace_events_user.c:
static ssize_t user_events_write(struct file *file, const char __user *ubuf,
                                 size_t count, loff_t *ppos)
{
        struct iovec iov;
        struct iov_iter i;

        if (unlikely(*ppos != 0))
                return -EFAULT;

        if (unlikely(import_single_range(READ, (char *)ubuf, count, &iov, &i)))
                return -EFAULT;
                                         ^ shouldn't this be "WRITE" ? This takes data from
                                           user-space and copies it into the kernel, similarly
                                           to fs/read_write.c:new_sync_write().

        return user_events_write_core(file, &i);
}

include/uapi/linux/user_events.h:

struct user_reg {

        /* Input: Size of the user_reg structure being used */
        __u32 size;

        /* Input: Pointer to string with event name, description and flags */
        __u64 name_args;

        /* Output: Byte index of the event within the status page */
        __u32 status_index;

        /* Output: Index of the event to use when writing data */
        __u32 write_index;
};

As this structure is expected to grow, and the user-space sample program uses "sizeof()"
to figure out its size (which includes padding), I would be more comfortable if this was
a packed structure rather than non-packed, because as fields are added, it's tricky to
figure out from the kernel perspective whether the size received are fields that user-space
is aware of, or if this is just padding.

include/uapi/linux/user_events.h:

struct user_bpf_iter {

        /* Offset of the data within the first iovec */
        __u32 iov_offset;

        /* Number of iovec structures */
        __u32 nr_segs;

        /* Pointer to iovec structures */
        const struct iovec *iov;

                           ^ a pointer in a uapi header is usually a no-go. This should be a u64.
};

include/uapi/linux/user_events.h:

struct user_bpf_context {

        /* Data type being passed (see union below) */
        __u32 data_type;

        /* Length of the data */
        __u32 data_len;

        /* Pointer to data, varies by data type */
        union {
                /* Kernel data (data_type == USER_BPF_DATA_KERNEL) */
                void *kdata;

                /* User data (data_type == USER_BPF_DATA_USER) */
                void *udata;

                /* Direct iovec (data_type == USER_BPF_DATA_ITER) */
                struct user_bpf_iter *iter;

                               ^ likewise for the 3 pointers above. Should be u64 in uapi headers.
        };
};

kernel/trace/trace_events_user.c:

static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
{
        u32 size;
        long ret;

        ret = get_user(size, &ureg->size);

        if (ret)
                return ret;


        if (size > PAGE_SIZE)
                return -E2BIG;

        ^ here I would be tempted to validate that the structure size at least provides room
          for the "v0" ABI, e.g.:

             if (size < offsetofend(struct user_reg, write_index))
                  return -EINVAL;

        return copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);

              ^ I find it odd that the kernel copy of struct user_reg may contain a
                size field which contents differs from the size fetched by get_user().
                This can happen if a buggy or plainly hostile user-space attempts to
                confuse the kernel about the size of this structure. Fortunately, the
                size field does not seem to be used afterwards, but I would think it
                safer to copy back the "size" fetched by get_user into the reg->size
                after copy_struct_from_user in case future changes in the code end up
                relying on a consistent size field.
}

kernel/trace/trace_events_user.c:

static struct user_event *find_user_event(char *name, u32 *outkey)
{
        struct user_event *user;
        u32 key = user_event_key(name);

        *outkey = key;

        hash_for_each_possible(register_table, user, node, key)
                if (!strcmp(EVENT_NAME(user), name)) {
                        atomic_inc(&user->refcnt);

                        ^ what happens if an ill-intended user-space populates enough references
                          to overflow refcnt (atomic_t). I suspect it can make the kernel free
                          memory that is still in use, and trigger a use-after-free scenario.
                          Usually reference counters should use include/linux/refcount.h which
                          handles reference counter saturation. user_event_parse() has also a use
                          of atomic_inc() on that same refcnt which userspace can overflow.

                        return user;
                }

        return NULL;
}

kernel/trace/trace_events_user.c:

static int user_events_release(struct inode *node, struct file *file)
{
[...]
        /*
         * Ensure refs cannot change under any situation by taking the
         * register mutex during the final freeing of the references.
         */
        mutex_lock(&reg_mutex);
[...]
        mutex_unlock(&reg_mutex);

        kfree(refs);

        ^ AFAIU, the user_events_write() does not rely on reg_mutex to ensure mutual exclusion.
          Doing so would be prohibitive performance-wise. But I suspect that freeing "refs" here
          without waiting for a RCU grace period can be an issue if user_events_write_core is using
          refs concurrently with file descriptor close.

kernel/trace/trace_events_user.c:

static bool user_field_match(struct ftrace_event_field *field, int argc,
                             const char **argv, int *iout)
[...]

        for (; i < argc; ++i) {
[...]
                pos += snprintf(arg_name + pos, len - pos, argv[i]);

        ^ what happens if strlen(argv[i]) > (len - pos) ? Based on lib/vsprintf.c:

 * The return value is the number of characters which would be
 * generated for the given input, excluding the trailing null,
 * as per ISO C99.  If the return is greater than or equal to
 * @size, the resulting string is truncated.

        So the "pos" returned by the first call to sprintf would be greater than MAX_FIELD_ARG_NAME.
        Then the second call to snprintf passes a @size argument of "len - pos" using the pos value
        which is larger than len... which is a negative integer passed as argument to a size_t (unsigned).
        So it expects a very long string. And the @buf argument is out-of-bound (field_name + pos).
        Is this pattern for using snprintf() used elsewhere ? From a quick grep, I find this pattern in
        a few places where AFAIU the input is not user-controlled (as it seems to be the case here), but
        still it might be worth looking into:

             kernel/cgroup/cgroup.c:show_delegatable_files()
             kernel/time/clocksource.c:available_clocksource_show()

Also, passing a copy of a userspace string (argv[i]) as format string argument to
snprintf can be misused to leak kernel data to user-space.

The same function also appear to have similar issues with its use of the field->name userspace input
string.

Unfortunately this is all the time I have for review right now, but it is at least a good starting
point for discussion.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
