Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDABEA3F1D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfH3Urb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 16:47:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32816 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfH3Urb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 16:47:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so309623pfl.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2019 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8u2magLfJVwljZAGYTURbma2mpmy7TrJLGdd0rfPWc=;
        b=BLGMZDX18kpe0sWfZwyNEN/x3wCg+PtSQX4ScBTDAaLkBAWub1CujNM5iGHBliKpEU
         ZrPu9ZzDjWPu5GHyQ7cmon0yZhz9fIJ+8H+HoH7SsGtQ4F++HJxCiy/VyWKWt+Xzw1WX
         O1OneofCTD2sRQcU4Aw0RD+89IEooAKz8I5pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8u2magLfJVwljZAGYTURbma2mpmy7TrJLGdd0rfPWc=;
        b=aT74WQZsQyWav29oxNJrJ+3l3SDXR3BoG6ftyIWUQ1wfGZR7CohhP/3m8nIE219c5b
         2WUa9yehVESQte2/pcux0uCzB+BmmWWQcM01Hxh0xKCSqpDGdXV0ijR6t+o7s5M3uOpR
         2fxCMMcS7xbA/Nfv0jmfHV4yvS3xY0U6U8kR7RW2V9XeMid6+zFKLEFXfBFyf7NZD+Vf
         KR86Kk8KVvVJRKtjX6sObtDQo/T92TGvJxqkYOcPPxzgPbSBVdqUtplzaVXqheuXUCDq
         I2sHUe82ao6TXzeQEioNFsV6ffqDLFzcRp1KuzBn1H2i/hVTcCR4RTyxD8Teaao/h7EL
         FLeA==
X-Gm-Message-State: APjAAAW+6h3UP/M31dFZ7LlMBT+Q1pkP51fE5GbRxyEs2mTfN8AxY/4l
        ibBiGoax7MF6LvlucgtG8iwVBw==
X-Google-Smtp-Source: APXvYqxMOrhTqkjdQCttFc7yV364Iys+Pb9Un4josyE2DbcbQpgmEtzeoZMjp+DQvlyXdnZOZftg4g==
X-Received: by 2002:aa7:9d8d:: with SMTP id f13mr5969012pfq.196.1567198050541;
        Fri, 30 Aug 2019 13:47:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4sm8770187pfd.109.2019.08.30.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 13:47:29 -0700 (PDT)
Date:   Fri, 30 Aug 2019 13:47:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Denis Efremov <efremov@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Message-ID: <201908301347.60905D1675@keescook>
References: <20190828210934.17711-1-efremov@linux.com>
 <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 30, 2019 at 10:08:49PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 11:09 PM Denis Efremov <efremov@linux.com> wrote:
> >
> > Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> > the define consistent with BUG_ON(x) in CONFIG_BUG.
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-arch@vger.kernel.org>
> 
> This makes sense, I've applied it to the asm-generic tree for now.
> 
> Two concerns though:
> 
> - adding unlikely() can cause new (usually false-postive) compile time
>   warnings to show up in random configurations, so we'll have to see what
>   the build bots think
> 
> - Kees Cook has recently sent a series for asm/bug.h that was merged by
>   Andrew Morton. If there are is a conflict with your patch, it may be better
>   to merge both through the same tree, either linux-mm or asm-generic.

FWIW, this patch looks sensible to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
