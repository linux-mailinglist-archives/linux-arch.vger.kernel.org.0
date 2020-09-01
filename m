Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1565A2588CD
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAHLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHLi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:11:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701CC0612AC;
        Tue,  1 Sep 2020 00:11:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so414677edr.3;
        Tue, 01 Sep 2020 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaw2TkC7UXssyjmtWIo7YhjBKV91Ck2RloWS+iSdWXc=;
        b=LWm1kQ+715+4kihaUwCTWCj4/r1I8my2OcJ9/8iHMLXPsa66IZzNOUQJ98RPamhH/D
         /NfmDPIOS5ufAOnWIja/4Po+C1xnHB5RmRDuPskUXbItWiLoGYDIjifxXG/VJzfOS8bE
         RhcfCm2+lzFBK5mLU5oIkt04Ocas1Xlj1FVOBAkF2oz7AX7UQLaS3f84vesYoN12E2O3
         Ehcz7xNsGKgp2ggLKFAlDzDdTOG5x5a3+QMDA8NDmU4g5iY8BrR0QNHmlOKAaPbXvU/w
         FgJA8P96gsRdlANF3S/vKy95h87iwx4K9XzG5c4vo4OxDtv2fQgUQfwPe5ywayJwdpZ5
         qchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xaw2TkC7UXssyjmtWIo7YhjBKV91Ck2RloWS+iSdWXc=;
        b=K6nzVYN1csFfFn2qbA4/uHZ6DPqlvkIn7yj5b1Jzg1EZbQAqZJMfeU81o3FFR+wL0D
         EacoTDxtwgMMDQhfPfBgyyxNgcVmD5F3x6EIPlDhFu3UJy7WuoOITVW3XJtTyvcR2jrW
         +vWFvYj0uJnKdasrgsmazfEC7GkbiZjpxt4r8U2eIk1pxLDQeFZ2MjQoAyOonfe302Te
         +OiK2JNCIXOaE+hlDX/YjVg+qW+TbC2mvoA9zk5a/Gp1E10m6pRTu24KNKl7jakHANjg
         lv7Y9TNvYlADc69QTAmbGb5tvOn+wUScSpxhnx7NR7Wg5Xlni9hQHa4RWLdXB+VJGen5
         wJgw==
X-Gm-Message-State: AOAM533sL7SQStXqZMVQ3DIxfHVdCI7b7UKkQs6XH4rr8MNQlJ7njhem
        iPCaupFzHvu2zn1PqIOzvvA=
X-Google-Smtp-Source: ABdhPJx0qvXYdPyQkstDBAZ0EUVd7eiEkHXZ5xJaa6Mf7E3AgRl/qjEMovJBDm2HHa0MzUd5CApWfw==
X-Received: by 2002:a50:fb15:: with SMTP id d21mr595347edq.150.1598944296562;
        Tue, 01 Sep 2020 00:11:36 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i25sm303304edt.1.2020.09.01.00.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:11:35 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:11:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
Message-ID: <20200901071133.GA3577996@gmail.com>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008311240.9F94A39@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Fri, Aug 21, 2020 at 12:42:41PM -0700, Kees Cook wrote:
> > Hi Ingo,
> > 
> > Based on my testing, this is ready to go. I've reviewed the feedback on
> > v5 and made a few small changes, noted below.
> 
> If no one objects, I'll pop this into my tree for -next. I'd prefer it
> go via -tip though! :)
> 
> Thanks!

I'll pick it up today, it all looks very good now!

Thanks,

	Ingo
