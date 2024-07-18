Return-Path: <linux-arch+bounces-5500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7DD935069
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F11B20C52
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEE7144306;
	Thu, 18 Jul 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WHfyZFP6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA914375A
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318772; cv=none; b=qys/o4GugKF3VL0IzuG6bCNM4vtBn8wgtVTP9nl0Al5Qo9KhVZn8qKFOExFNKjcd6eqUCs1NSKUNafccGZ+O5NnPsyZ2efDWMD6C12/fTkJXy2hObsYlR8ykm8gi2YQBOXPEdPoRbf9vSZ/C2ahsNHp2PafXrtH+RF5bQW81RAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318772; c=relaxed/simple;
	bh=44n4cYZ0Q1E+j8qZTmA1s4xcBXqhsiYahsmpu+O2AOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngWwzHziTIpqRCDrx/MniZFRxnzOIyX7qi2XUxcknZno4fnnWBJnBLCdIut0y8vsBev6rmL78AbPXE7I7W1nv6IBHbpPWJSLuiPdHc8yLmcQPL8Po1bwXXjN4nb8jbOFOOGhemlqVFlTRAYNA+Z5YlbwkYDC+ONp1Ac8NTOmt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WHfyZFP6; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-382458be739so3703265ab.1
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721318770; x=1721923570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viUABkBmfTgkqCa/7vhlbq4p5oq9ftTQ0S5SnBOY0Nk=;
        b=WHfyZFP64SaNudMQ4iTCht83En/c9xFwE7WseUsES7dHvk+J1Eo8zrp5kPDICxbTKJ
         tL1CxdMO2l0GUb56AdvTGTisCyo7qoWYz/wFoH38kpm8ecuQI2dRIjuGDG9RtpTl8Sdr
         46SSbr1/5JbmLSzP4bXUhjwYxrLbVh3CXGbi2VvApTUBLb9ICyaEesHmHV1E7WpFRJVB
         3KplswpqsksQoO/4gFDBTiyFMPyRZTIZn3XbfNF2rLYbvR75kgpBSVfq8Hjov0ompmS2
         kvknIrFw1Idx710SVRlUSLU/2jmnqTfo/6+f6bNN44C0y15k9mkLy72q2X02BvGKu8t4
         e1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318770; x=1721923570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viUABkBmfTgkqCa/7vhlbq4p5oq9ftTQ0S5SnBOY0Nk=;
        b=CtHbXr7F3/tDKzauz7N9fJKL3hI7Tgzl/DZj/BOMC/t+TbX14Kmlslbf56odPMuDM+
         /3S1DEJUkfqIMnvGXvdTdVjJc9/xpVSungUtYzET09ufcyM17pWJ9gGiCCXAHecHk42F
         +eNKDohVVnOCxKuD9AWIGZ5sKikYt7okQsWClZtEBT+VLZ66fTPBnLHXtWbXSAam7KlP
         rLeWh/DNU3UiXKXt5cu/TELT+1ksufIg/i/Wj/y3OZUYVgY6bjw35LRmgRoP1g5I+LYs
         l2oSIa5Q8D+0eCbUQnIi28aMMNlopoOR9SFUB2AkaEwrNFkcwuFBdAbkV/E8OBe7ghWd
         6Txw==
X-Forwarded-Encrypted: i=1; AJvYcCXxn7IMDB4RBy0cCVm0T/ck8uWgKWOqvmht2jpcb2YA90aoaNksJfBaWMOAgxXQHG7LSWOH5SsJoQECY2Js+XSG1RnrhF+9yrGo+g==
X-Gm-Message-State: AOJu0YyWOToX97O57vELNnmMf3+HbiCRkj/cY7kcEikQg+9RI2GUPmrT
	gd4+K8gxAIvD3DI7GljB9h1Qe8faF0iukOzh+ext86r/9GnscTz1h4fuphgmW4/ZvJmWFS8UBGL
	1Zr8=
X-Google-Smtp-Source: AGHT+IFm1MwbtKKQ42pdLPFRWB3QURVJC7xbjJO/hmp2xPNIG+w6wDszyBZqmIMxtUybkHCFqiqGvQ==
X-Received: by 2002:a05:6e02:1e0e:b0:376:4049:69d2 with SMTP id e9e14a558f8ab-3955542a2f1mr76353275ab.6.1721318769739;
        Thu, 18 Jul 2024 09:06:09 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950b6ad778sm17393005ab.40.2024.07.18.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 09:06:08 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:06:06 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 03/11] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240718-d583846f09bc103b7eab6b4e@orel>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-4-alexghiti@rivosinc.com>
 <20240717-e7104dac172d9f2cbc25d9c6@orel>
 <fb03939b-502b-410a-85f5-2785b2bd0676@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb03939b-502b-410a-85f5-2785b2bd0676@ghiti.fr>

On Thu, Jul 18, 2024 at 02:50:28PM GMT, Alexandre Ghiti wrote:
...
> > > +									\
> > > +		__asm__ __volatile__ (					\
> > > +			prepend						\
> > > +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> > > +			append						\
> > > +			: "+&r" (r), "+A" (*(p))			\
> > > +			: "rJ" (n)					\
> > > +			: "memory");					\
> > > +		goto end;						\
> > > +	}								\
> > > +									\
> > > +no_zabha_zacas:;							\
> > unnecessary ;
> 
> 
> Actually it is, it fixes a warning encountered on llvm:
> https://lore.kernel.org/linux-riscv/20240528193110.GA2196855@thelio-3990X/

I'm not complaining about the 'end:' label. That one we need ';' because
there's no following statement and labels must be followed by a statement.
But no_zabha_zacas always has following statements.

Thanks,
drew

