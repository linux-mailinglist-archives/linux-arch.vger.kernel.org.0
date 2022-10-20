Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB70606855
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 20:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJTSle (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJTSld (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 14:41:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1248208806
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2022 11:41:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so146452plb.2
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2022 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nPBTU3PqdP5EK9iSk8h8ufgxACQharp0pBd9nt0BIc=;
        b=V87BkIgQjC4K7MYDNkBaUMfBiwNsRounMByDxYac7tRM8jK6sBUrEZidRmmlXpC9YB
         Ie7MDrLvE6AArCQgek5J0VqBNd+y0aPXnEktH0qMOtcLrMv3Jw3ejmBf8/tdQz1xaKPC
         A7AUcNXuDyNgx3VmkwC8GEorFfF+SdXKj2Enc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nPBTU3PqdP5EK9iSk8h8ufgxACQharp0pBd9nt0BIc=;
        b=iP3ooD7mRYjCPvDtloUZUAA3NyIFstjLAmW98aeVhxtMSMjZk+Ca3OfaqZRbMYHz7W
         V66NlmJ9WcCM4iWuziXZqByO4gpv76DavAbpl4eIQcCyGIVmA1oP3eq6UrDQiyRYZvGt
         XG5FJe/WDzDeHjN8eBn78+8yH/nOc7sGZHJB1uqxHSrelHSZOGBfFCNQTfnZngfw/4di
         DOpK/rTEaFbUXWXi9lpWVOFNGvVKGhIuiYXIKA2L71kQaYJApftfqzhohNMMLm+xi93G
         WBQS2FRqvJkhdbxirhxVcAtScGqh5qH7r+eB49GEQW42p2To1RRTwSf7INMWolmKZwAF
         bJhQ==
X-Gm-Message-State: ACrzQf3E3ZRAEioL7vOCR0sjkNDR/Gf7/EWTr+gB/7LjpMSDfyR4Jddh
        j6dvARkTbM8r/Yh9ydKILeve/Q==
X-Google-Smtp-Source: AMsMyM7jtj0lrm66FgtcXeuW3VLHNK1EiZ1HwCHhzPxNj/ARdDq42D4QCAl03CKpknF5hSdF+2b6lg==
X-Received: by 2002:a17:903:22c1:b0:184:983f:11b2 with SMTP id y1-20020a17090322c100b00184983f11b2mr15663540plg.40.1666291291263;
        Thu, 20 Oct 2022 11:41:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b0017bb38e4591sm178160pll.41.2022.10.20.11.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:41:30 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:41:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <202210201056.DEE610F6F@keescook>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com>
 <Y1CP/uJb1SQjyS0n@zx2c4.com>
 <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 05:38:55PM -0700, Linus Torvalds wrote:
> Having some scripting automation that just notices "this changes code
> generation in function X" might actually be interesting, and judging
> by my quick tests might not be *too* verbose.

On the reproducible build comparison system[1] we use for checking a lot
of the KSPP work for .text deltas, an allmodconfig finds a fair bit for
this change. Out of 33900 .o files, 1005 have changes.

Spot checking matches a lot of what you found already...

        u64 flags = how->flags;
	...
fs/open.c:1123:
        int acc_mode = ACC_MODE(flags);
-    1c86:      movsbl 0x0(%rdx),%edx
+    1c86:      movzbl 0x0(%rdx),%edx

#define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])

Ignoring those, it goes down to 625, and spot checking those is more
difficult, but looks to be mostly register selection changes dominating
the delta. The resulting vmlinux sizes are identical, though.

-Kees

[1] A fancier version of:
    https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

-- 
Kees Cook
