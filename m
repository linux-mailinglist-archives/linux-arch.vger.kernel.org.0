Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B522565D20
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiGDRhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiGDRg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 13:36:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F0712AA0
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 10:36:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fi2so17811917ejb.9
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJyesbik3li+nd7lTgRBI8S9OD6JxlDs1GIHpVzW1PQ=;
        b=fwlp1HglFHpX7O+wTF2XFvDWUo4ymN7/Rg1c4kPC5Eo6huCSyB0caRrsz6TFxUX8uX
         qHBcGYMvaNyvVCGIUL8QHtTWVIH0IUT+rGAL3vVJRHDlPNjZBZEB7KnXg7NwJI8bS3PZ
         v4KpFB9uFWPZ7wy3+FjBv+XuIC8U8KIqUqUIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJyesbik3li+nd7lTgRBI8S9OD6JxlDs1GIHpVzW1PQ=;
        b=O7ArEMNYxE4F9580hc3NQH4kQPUUcdeDUod0aBthirbmEc8UKGU2LGNeHTjiWsENpM
         +0z9AMhNICBem+w5LiiKsR15mtl+DJ1JtOfQnGwBY9djawXyrMPLTFQL2WnS3Dlfl4AI
         DBQpr5+3b/WINGegXpDwsVQqWf9jttTZvuofe8IPD/WBUsCuaQzPLYa4Ag3gLh13imF4
         uh02wh9bzzOTpyRbTLSkECexnJ3zJi/Ux8N6bXLqS+3cVUhAcB7JbsNdX+8Rsydq0gat
         TGrA5P7K50tQluQsHIoB0lkRroG0u/lxRK/Smku6i0mVph5/8SbTTc849sYReeUSLD+s
         ANnQ==
X-Gm-Message-State: AJIora/jF+CKdtgv1Py/PXu1/f6TtnQgOkk42P3ud0UqiY0cphcXaYtx
        F24Kc7njTaC7PKk/XQt+fdPeezyUWRdLcEMZ
X-Google-Smtp-Source: AGRyM1tq7zTWN+iJBU5qVC29Daaeeomub76UkNdeAwedgxB6jaHhE4dDa9oe5GP23rNL17ywhtSO1w==
X-Received: by 2002:a17:907:2ce4:b0:722:df67:12cc with SMTP id hz4-20020a1709072ce400b00722df6712ccmr29985277ejc.715.1656956193012;
        Mon, 04 Jul 2022 10:36:33 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00726dbb16b8dsm8833987ejp.65.2022.07.04.10.36.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 10:36:32 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id c65so12520068edf.4
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 10:36:32 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr27345923wrx.281.1656956181432; Mon, 04
 Jul 2022 10:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com> <YsJWCREA5xMfmmqx@ZenIV>
In-Reply-To: <YsJWCREA5xMfmmqx@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 10:36:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
Message-ID: <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
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
        Marco Elver <elver@google.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 3, 2022 at 7:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, trying to write a coherent documentation had its usual effect...
> The thing is, we don't really need to fetch the inode that early.

Hmm. I like the patch, but as I was reading through it, I had a question...

In particular, I'd like it even more if each step when the sequence
number is updated also had a comment about what then protects the
previous sequence number up to and over that new sequence point.

For example, in __follow_mount_rcu(), when we jump to a new mount
point, and that sequence has

                *seqp = read_seqcount_begin(&dentry->d_seq);

to reset the sequence number to the new path we jumped into.

But I don't actually see what checks the previous sequence number in
that path. We just reset it to the new one.

In contrast, in lookup_fast(), we get the new sequence number from
__d_lookup_rcu(), and then after getting the new one and before
"instantiating" it, we will revalidate the parent sequence number.

So lookup_fast() has that "chain of sequence numbers".

For __follow_mount_rcu it looks like validating the previous sequence
number is left to the caller, which then does try_to_unlazy_next().

So when reading this code, my reaction was that it really would have
been much nicer to have that kind of clear "handoff" of one sequence
number domain to the next that lookup_fast() has.

IOW, I think it would be lovely to clarify the sequence number handoff.

I only quickly scanned your second patch for this, it does seem to at
least collect it all into try_to_unlazy_next().

So maybe you already looked at exactly this, but it would be good to
be quite explicit about the sequence number logic because it's "a bit
opaque" to say the least.

                   Linus
