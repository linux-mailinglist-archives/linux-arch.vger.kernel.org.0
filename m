Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782CC78FFEC
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 17:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbjIAP2n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIAP2m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 11:28:42 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E0E70;
        Fri,  1 Sep 2023 08:28:39 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-570e005c480so1284634eaf.0;
        Fri, 01 Sep 2023 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693582118; x=1694186918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ2Fg59GpO6ELXJepkz+Etiwl3az70VeBDwTtXPnp9U=;
        b=egIlqfim/YXEVfELoqApCdZx08q1tjRVUyijDIoQH32jpIlpeeRz3kNpBLcpFNAxYr
         x/uR3Blzk/b9I1bJaIStysVtFGVSDVNLptEep/0LrErkHOSLwU32IUGWq9dq3NihfsSH
         mfswvldG3x+uQP57G/IKkDysuHI9guH6wzNEu/IjRZD0WDxVAKfNApj2iHIzxVPRYnvV
         dyh8GKF1S/vY4TV/ZdXqB+CptAYcBb8gYarYetGcCNeFHEPA5JiseQHaguLWq2EmNFfJ
         rr4I5XZ6wJOmh61jt9/NaTGzH+WC+sdOXukbEaK7RyUj1NDlu+RdI22tVcpUMvZsOwNs
         sb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582118; x=1694186918;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ2Fg59GpO6ELXJepkz+Etiwl3az70VeBDwTtXPnp9U=;
        b=FNWAyJ7n9zXkdUIRhs4+GdTGGlii2r8sgD4qo/piXa/yfQRQOV3Xr8+Rhf14MPlbmH
         XT1ezGujFcd0OM0Vv1EwR0Wur5CR4IHUC8WvuhmLiKHp8beFgXzu/rtAP4pGX76izXck
         SMU92rWeK3E3szywo25YxKxDiGGcZCrNlQMGackjly8MEMm8MRPxPhwsE57hJ5MCjYsT
         7vvBqt1MbUPuL5+VQz6J8lKUICnnvMbPImqgA2uYxDUJcP/Hcsu5daOdAqPA/qzyN20N
         nBLswhZ+4ukz1cdbUFQUuTYL+CWmao/bEeHcdAoNPkUbnbudFZlSad1Il7C1CE/f3Bdm
         BjlA==
X-Gm-Message-State: AOJu0Yz6jdmUvZIVnVx+Br+1bDXtHejCncpKAb62RirbG2GidtigSqns
        SiQwivtXyEawHQJXhnvAzc70cY/Nr0iSR9U5lMc=
X-Google-Smtp-Source: AGHT+IHk85EsPgpHKvMzvFX6rQAqsjUGzExC1ZNbz5s8xuR24hREKmtSXe7pHJi9apHvD6j4stIqCJDSP4trQ0e4hSM=
X-Received: by 2002:a4a:2a13:0:b0:573:b2a4:7a6e with SMTP id
 k19-20020a4a2a13000000b00573b2a47a6emr2850729oof.5.1693582118309; Fri, 01 Sep
 2023 08:28:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Fri, 1 Sep 2023
 08:28:37 -0700 (PDT)
In-Reply-To: <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 1 Sep 2023 17:28:37 +0200
Message-ID: <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     David Laight <David.Laight@aculab.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/23, David Laight <David.Laight@aculab.com> wrote:
> From: Mateusz Guzik
>> Sent: 30 August 2023 15:03
> ...
>> Hand-rolled mov loops executing in this case are quite pessimal compared
>> to rep movsq for bigger sizes. While the upper limit depends on uarch,
>> everyone is well south of 1KB AFAICS and sizes bigger than that are
>> common.
>
> That unrolled loop is pretty pessimal and very much 1980s.
>
> It should be pretty easy to write a code loop that runs
> at one copy (8 bytes) per clock on modern desktop x86.
> I think that matches 'rep movsq'.
> (It will run slower on Atom based cpu.)
>
> A very simple copy loop needs (using negative offsets
> from the end of the buffer):
> 	A memory read
> 	A memory write
> 	An increment
> 	A jnz
> Doing all of those every clock is well with the cpu's capabilities.
> However I've never managed a 1 clock loop.
> So you need to unroll once (and only once) to copy 8 bytes/clock.
>

When I was playing with this stuff about 5 years ago I found 32-byte
loops to be optimal for uarchs of the priod (Skylake, Broadwell,
Haswell and so on), but only up to a point where rep wins.

> So for copies that are multiples of 16 bytes something like:
> 	# dst in %rdi, src in %rsi, len in %rdx
> 	add	%rdi, %rdx
> 	add	%rsi, %rdx
> 	neg	%rdx
> 1:
> 	mov	%rcx,0(%rsi, %rdx)
> 	mov	0(%rdi, %rdx), %rcx
> 	add	#16, %rdx
> 	mov	%rcx, -8(%rsi, %rdx)
> 	mov	-8(%rdi, %rdx), %rcx
> 	jnz	1b
>
> Is likely to execute an iteration every two clocks.
> The memory read/write all get queued up and will happen at
> some point - so memory latency doesn't matter at all.
>
> For copies (over 16 bytes) that aren't multiples of
> 16 it is probably just worth copying the first 16 bytes
> and then doing 16 bytes copies that align with the end
> of the buffer - copying some bytes twice.
> (Or even copy the last 16 bytes first and copy aligned
> with the start.)
>

It would definitely be beneficial to align the target buffer in this
routine (as in, non-FSRM), but it is unclear to me if you are
suggesting that for mov loops or rep.

I never tested regs for really big sizes and misaligned targets, for
the sizes where hand-rolled movs used to win against rep spending time
aligning was more expensive than suffering the misaligned (and
possibly overlapped) stores.

If anything I find it rather surprising how inconsistent the string
ops are -- why is memcpy using overlapping stores, while memset does
not? Someone(tm) should transplant it, along with slapping rep past a
certain size on both.

-- 
Mateusz Guzik <mjguzik gmail.com>
