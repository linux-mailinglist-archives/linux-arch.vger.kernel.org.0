Return-Path: <linux-arch+bounces-6905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD309968241
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8781C2216D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668E186E33;
	Mon,  2 Sep 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PKU9ECjX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236D186601
	for <linux-arch@vger.kernel.org>; Mon,  2 Sep 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266661; cv=none; b=Mg7Ou11tGCC08NZHtu9pFUAtS/I3JO7CUDGUEajCzmV7S0S2MG9Okd/Fuxhl4ktpDVPN0j+HzRWI8CUHIQaJoLqjR1R9gmZ1oLwdVGXX5IA+BSY4sqtGDOzymTjtD5QinXyUKPAypbSfo10IBu9UVeummq759epz4LbNqQjivqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266661; c=relaxed/simple;
	bh=LN6JNZFcXNQtWOPufPtp0JNJPUrJ2pZL1p27gLGF2IY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfJbR9w6y1CYNueeW8jGPOReNSRuT/J3kBKrpIkHFU2rJVeZeN37O/OrRCcI72M5QHbpXZpLJd73TRpkwfjoPu87uCcq0OBajw8ZiiQKE5GQMr/QVDTKvfRzBSdQrdyvfbxuAv6jN1oX2UKHSQ0n8dfSyDNJ8X2dJLU48FtFTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PKU9ECjX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c0ba8c7c17so1681678a12.3
        for <linux-arch@vger.kernel.org>; Mon, 02 Sep 2024 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725266658; x=1725871458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtFvUOlggwnSeLAOJpUbgPD+rPcosq7JSEShF0DBVDE=;
        b=PKU9ECjXqYYYZd+EgOrpddJ7gjntAgBch69LAvTaqeFsw/Q5HhZhNQvQE1K0NuWGyQ
         A+euPMUH4u3HLf5Zs3977HYTTkEb/yr6+ybtIyGCusMspUNCnGbyvZi1Iw8tj614pE9M
         phwuW8Q7xz94M9p0CGn801SqEQjMDnGt6olrqMwp2HtMkROcXM+286Qy22K3FL6/ovaB
         y3trBB0hRJYg2XJsxKZ4tGlG+BuqPld8jnSmeYZbFC2NJkBJ9QOrGyUj/C5qLtAFaS/+
         J8OFkINSiiniHyrale2zfpDIfWY2/FKfKYXcM2ps9ukDgXNYcTpC74ZSH+5GFvUfXaFf
         Feew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266658; x=1725871458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtFvUOlggwnSeLAOJpUbgPD+rPcosq7JSEShF0DBVDE=;
        b=Hu0nRG3/CrRljfFYmaq1JuX5Kqf5hwj7WDyJmSIYnkvuAa+ewz1vCK0lSoUK3nyLLq
         llqo+gYyRvcOkjzfp73BgkHN9PxEnxWVYL90NqFCdM3EyiKEc2DW4dOi5ZFA1yApQhrg
         GkwEAQjsrozgv5Fr2XUFBSyYc4m5z/sIi5y/6KoSxGEZinsJi2puC8nhrj/Bs0KL7HJ5
         8gxdccLqhMoSgoyFlOvCFTT8gcBUyUSEORGZXHLInU/SY3SA2G3uRocwDpPIhKdUYGXw
         k4ltnt4rbvORcvOb/2mQ2UFT9HjzFOEIxdrmE1e7Bk8OU0IyPxE9m8UZvSALVkx3zUyk
         1CCg==
X-Forwarded-Encrypted: i=1; AJvYcCVbQl19/TD+JP5Yy16ERvPCzIid3zeEVgZR6xTDY4lO9ypKAKo1mIVphBv+40nP9fKmCuZalREulPgB@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6lfeq81dFREe8g0HVKO42X6wtOgMcAPt/rrt2xvxPNaIb6Nk
	wcQ53MDmeQ7RPIPZWUHflVghgwVLESpuXVMwhofJf5vADIji9eFxZxK4O3k+ErA=
X-Google-Smtp-Source: AGHT+IG98mGI6ewy00GdXcZOqWLixBDXOEPu/wYdqw/JNaxYhNTMsSkYAS1b2LLsz7REgS8Iyi90kg==
X-Received: by 2002:a05:6402:40ca:b0:5be:9bc5:f6b4 with SMTP id 4fb4d7f45d1cf-5c21ed315fbmr13546644a12.8.1725266657478;
        Mon, 02 Sep 2024 01:44:17 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c1f7sm4978743a12.42.2024.09.02.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:44:17 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 2 Sep 2024 10:44:24 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 02/11] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <ZtV66FOMJitMmtTv@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <82d57814075ed1bc76bf17bde124c5c83925ac59.1724159867.git.andrea.porta@suse.com>
 <5zlaxts46utk66k2n2uxeqr6umppfasnqoxhwdzah44hcmyfnp@euwjda6zk5rh>
 <ZtGdTjZPYtm3EGM0@apocalypse>
 <e05705c1-95dc-4d77-8a0d-8c2a785b0b05@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05705c1-95dc-4d77-8a0d-8c2a785b0b05@kernel.org>

Hi Krzysztof,

On 13:46 Fri 30 Aug     , Krzysztof Kozlowski wrote:
> On 30/08/2024 12:22, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> 
> ...
> 
> >>> +#define RP1_USBHOST0_AXIS_BASE 0x200000
> >>> +#define RP1_USBHOST1_AXIS_BASE 0x300000
> >>> +#define RP1_EXAC_BASE 0x400000
> >>> +
> >>> +/* Interrupts */
> >>> +
> >>> +#define RP1_INT_IO_BANK0 0
> >>> +#define RP1_INT_IO_BANK1 1
> >>
> >> Also no, interrupt numbers are not considered bindings. That's too much
> >> churn. Otherwise, please point me to driver code using the define
> >> (directly! that's the requirement).
> > 
> > As mentioned above, RP1_INT_END is used in rp1-pci.c. To get rid of all those
> 
> Number of interrupts is not a binding, either. Does not appear in the DTS.

Ack.

> 
> > macroes from dt-binding would mean to hardcode the interrupt number in both
> > the binding example and in dtso, from this:
> > 
> > interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
> >              <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
> >              <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > to this:
> > 
> > interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
> > 	     <1 IRQ_TYPE_LEVEL_HIGH>,
> >              <2 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > is this what you are proposing?
> 
> Yes, just like every DTS does. I think the hard-coding of numbers is not
> a problem.

Ack.

Regards,
Andrea

> 
> Best regards,
> Krzysztof
> 

