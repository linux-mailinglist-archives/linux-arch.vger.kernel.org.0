Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B342EE7E7
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 22:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbhAGVuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbhAGVt7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 16:49:59 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FDFC0612FC
        for <linux-arch@vger.kernel.org>; Thu,  7 Jan 2021 13:48:55 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so6152625pgc.8
        for <linux-arch@vger.kernel.org>; Thu, 07 Jan 2021 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2y5ldgOdSGehetTiBK+U8i5swyTNR/kRJ3FUEfcFsM=;
        b=PV5pr53syG3dJsfA06CxIQT0gd9pQVQsuR4CvYMsj3OJ+auH8BqHVAvz2r/fIBJU8/
         XShYvN5UqNLnFx2Bm/nywgy5zgJN8CqkWY58vc97jKtFG4u28IOAf1lOB32Bw2kAPnEk
         ZkNpANy4OUDLzobPKA1GBex5W1U6laQmIc84Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2y5ldgOdSGehetTiBK+U8i5swyTNR/kRJ3FUEfcFsM=;
        b=W3wIcl6sPB3x2YAqfZOKTdVSqkaBa5eMLkd6mRWLWysHrt9K8Viw/PiCC+F4pSNq21
         qKQWS2sEnQpylZeWcrKdFL/qp0oY5X6zD4KocmVzsTl0JOLVng2Pir/l2rCoIDi2m3qw
         zutadnKTFHRhp499R7EpEHGCV0pxXIzH49Cu+WyLhnpbPR9U4BtgmIOkALmidBGmjEPF
         KAOCObEQQJy7jCMMHe/owZK212icbaIbZFBkMseOgjDpei+RqCixhlHfN1cSmKV0L3aQ
         vR4QURSOvfa42IDGYVfkuHIAG+Lz7553C9+Ybq21QPuyKZCjHd1VWNTY7B6rnxVCiXXv
         Ruiw==
X-Gm-Message-State: AOAM530zLQOTa5or2AMEZzuIkwSD0UnRBnrY8d8cmQJ329n74o5z6aPU
        ALBiE16O5HM66ZlV+eIouIyLJw==
X-Google-Smtp-Source: ABdhPJwbQHso1tC0FO/UsuRezTvfVCAcWK00QzM7FO5Ywnbq4jpwL9pZJqkwZtGQFsNAvJTtD8KjZQ==
X-Received: by 2002:a63:720c:: with SMTP id n12mr3815960pgc.97.1610056135097;
        Thu, 07 Jan 2021 13:48:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm6393784pfj.91.2021.01.07.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:48:54 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:48:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 mips-next 4/7] MIPS: vmlinux.lds.S: catch bad .rel.dyn
 at link time
Message-ID: <202101071348.301DA51@keescook>
References: <20210107123331.354075-1-alobakin@pm.me>
 <20210107132010.463129-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132010.463129-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 07, 2021 at 01:20:33PM +0000, Alexander Lobakin wrote:
> Catch any symbols placed in .rel.dyn and check for these sections
> to be zero-sized at link time.
> Eliminates following ld warning:
> 
> mips-alpine-linux-musl-ld: warning: orphan section `.rel.dyn'
> from `init/main.o' being placed in section `.rel.dyn'
> 
> Adopted from x86/kernel/vmlinux.lds.S.
> 
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
