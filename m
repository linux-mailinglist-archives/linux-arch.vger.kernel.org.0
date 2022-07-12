Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4084E571BBB
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiGLNwJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGLNwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 09:52:08 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24234B62BC
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:52:08 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e69so14048868ybh.2
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWp5/64or+mP5imIMCPIUbpfNaM35wXtmKXqwrNhd14=;
        b=fLRarT5d7pJmh7A50/oCtJdSEsMl6AUE3JJAWBUs5VRHku5TfmA2ZaNuN9yxSHaiIN
         uwtuacBFDfHbwF6Bm+jjGZvODksVkWM5jxN3OkliOz894DxvftnJTqBwbIKjL3a5Jg7O
         aD/FvQUvMXwFSfDXS95BPdRaSu7iLOPKW1iUcwu/8mbh2rgEJYfXBSvs5rJCN+tbCW5B
         j9nesILDH3K0YJDH31eTwvUt6JTHN6f/36ZkIpJmZn5kpG6CapCdvx0JiOFJWYt0Wlhp
         +g0M1lIyMMzrKYY4H+JmEQ3F9zNBW040MDY9TBTTgYfY69+SrLs4HRdOEbdtzaKYoX2a
         DFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWp5/64or+mP5imIMCPIUbpfNaM35wXtmKXqwrNhd14=;
        b=pLGn4l7eBjx2L4qtiW6DpBkZ8bzooXmyYIOdY59WXqI9s1SlHijSRSolEX9BmukTM1
         GTCVW8gPpyLTRbJ3wVU/xXgHUkCLFhhZFOwrILMWmGSTi7BgEBwYIkBHk1aOZMIY4fLq
         hiUmJjFnJwgIUftwuR+LlCJyNDd9pGgZW3ty7EY6FxKueqa3vxaMoDeTnWEjyLshIIvZ
         X7UvwE+fJz1lBUjamZa3GgWkWXwf5RVkZhKzglcX2g/Az7vm93nJgnUR6jnl6PoZR/rU
         Go7esTnNzL8ets15974MTCysoZHzkXHXV6RtZrb4zFXYYZTcodNBpg1/Vy0kkiHlTg3t
         nE7g==
X-Gm-Message-State: AJIora//9aC/mU9s56uk3zOXkcwlgNAq+ZBzARZX7sj4QpPxb/pN5MAE
        K1HMJtsXA4mIsL+y61E4VnzIeSihRMxAUrQFNirFfw==
X-Google-Smtp-Source: AGRyM1vaXhDrW9SzgGVGnQeO3sKZbN8zrYy0RbeU0jBi1M5Io3ShqhFaENqRfTiUKywPAI3ytd02a4hWcGbWqnCnWlg=
X-Received: by 2002:a5b:10a:0:b0:66d:d8e3:9da2 with SMTP id
 10-20020a5b010a000000b0066dd8e39da2mr22834061ybx.87.1657633927213; Tue, 12
 Jul 2022 06:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-19-glider@google.com>
In-Reply-To: <20220701142310.2188015-19-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 15:51:31 +0200
Message-ID: <CANpmjNOPJL7WAUh5CUZOYO8hY-dHTHMUMJzd9OGbmWES+smtrQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/45] instrumented.h: add KMSAN support
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:24, Alexander Potapenko <glider@google.com> wrote:
>
> To avoid false positives, KMSAN needs to unpoison the data copied from
> the userspace. To detect infoleaks - check the memory buffer passed to
> copy_to_user().
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

With the code simplification below.

[...]
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -212,6 +212,44 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
>  }
>  EXPORT_SYMBOL(kmsan_iounmap_page_range);
>
> +void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
> +                       size_t left)
> +{
> +       unsigned long ua_flags;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +       /*
> +        * At this point we've copied the memory already. It's hard to check it
> +        * before copying, as the size of actually copied buffer is unknown.
> +        */
> +
> +       /* copy_to_user() may copy zero bytes. No need to check. */
> +       if (!to_copy)
> +               return;
> +       /* Or maybe copy_to_user() failed to copy anything. */
> +       if (to_copy <= left)
> +               return;
> +
> +       ua_flags = user_access_save();
> +       if ((u64)to < TASK_SIZE) {
> +               /* This is a user memory access, check it. */
> +               kmsan_internal_check_memory((void *)from, to_copy - left, to,
> +                                           REASON_COPY_TO_USER);

This could just do "} else {" and the stuff below, and would result in
simpler code with no explicit "return" and no duplicated
user_access_restore().

> +               user_access_restore(ua_flags);
> +               return;
> +       }
> +       /* Otherwise this is a kernel memory access. This happens when a compat
> +        * syscall passes an argument allocated on the kernel stack to a real
> +        * syscall.
> +        * Don't check anything, just copy the shadow of the copied bytes.
> +        */
> +       kmsan_internal_memmove_metadata((void *)to, (void *)from,
> +                                       to_copy - left);
> +       user_access_restore(ua_flags);
> +}
> +EXPORT_SYMBOL(kmsan_copy_to_user);
