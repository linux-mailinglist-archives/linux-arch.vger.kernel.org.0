Return-Path: <linux-arch+bounces-6513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA7F95B28C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C3B23C60
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BBE17DE15;
	Thu, 22 Aug 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cjd0qZgh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9B17B401
	for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321073; cv=none; b=LIeDjQ1Lo888XO2H2oZiKhjQyw286Z+FDrQoX1xXrYqgYZBeuvAlEHc2YavUwJPEsx9mFslioumxAmgf8zpex82Vts7+OEPFuTS00Rw0FTNtA/PksYZIDQCeEw3vGlcAKM9aDJNMwv/OhgSbY/2s0LTyXIHFitr6kCODcBJBvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321073; c=relaxed/simple;
	bh=xxyoPJfX24KJoyxO6jEzwtrU2Hoh+t/Pzgync5R29bw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjPuRP1ciy2YBHOm4WIkJV7fweey1Mr0tN49VwjVp626dTioVfI7k3PEnhjF4IJoW63x+0cQKW1oeJqbo8Neljwvt52ZcQfPY/yN9YgJCBuWxXruJyjMt7bF+I+p+jQd7LL5bH+BMod9vWVCFVK6jNc+mTHWxHPeOzGWXGuGfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cjd0qZgh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86984e035aso21333866b.2
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724321069; x=1724925869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpyK4IsQzJrI6qeJJhvprKefQNt+Ld7JQCqPLKfE9e0=;
        b=cjd0qZghW7v0ktHKohaYYLp+lK+DySxFbu34qndmjCyWRs2wDG5qBO45dz0EwS0R0i
         0ENCdE8+ChXf1PSynPrqXNYD4VPJpJaCOkc2cj/b468r//RB1wegrQdTUDpZURtZ7dOT
         2vZ7wo0Gavo+Va1aEUOy2l13V5qayiFiohQQWgsRqnJiFZH2aB4MA3DrjNGgIYHL4zox
         kn1PzOXREbrp3z7h2Sf1yy9VRyzBzIzyUl1BUGiDvB/X+I+QxNGjc2TBRn8ogA5e5aGI
         BZPueo2fQcKSCGYnoI6NQ3hulR42mQJ/a7RsYYTkrJhoEvc7V0f7ZgsZmQ+EWCN4JqIQ
         kRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321069; x=1724925869;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpyK4IsQzJrI6qeJJhvprKefQNt+Ld7JQCqPLKfE9e0=;
        b=f2rhlzeLbWnQgWrC+2p5ZKLOFEuVc8o+v3kAYxSYxUKnRAhVKho4DjOlcscrG2bsTf
         NdDZqvbHrr7AjWsS6eNq6eRCpXlm/9AKDv1ap9IQ0WUd15lnV3jtjY9NKHrd4m85LJCg
         pZYgNwAGl1lyIwfKx/ugFMMoMKDAXxuYmhVKMZDkt5D6V02IYgJ3/RAkJwuExK1456wT
         gwIUCzpq6sLlC3NH5IarKK+8s0Em/pLWnphMwTqIRU4xAxlooRJo7LlrZosLKiacMe52
         8YKFEZ7dfuKvZRtx3IM2TAvGDxUX1UJ7FQlb6VbbXfm2LuhP+L284vConyKmG7ySenFH
         9Y9w==
X-Forwarded-Encrypted: i=1; AJvYcCUm6YZumm/4dgoyXw8lMD91D586g06LVqZorZDkOWyNfeELMvrnFlBfazijag9bVgk0LDLlViFoNOvp@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbe2QUacVNkG30hym4puq6POv/8vA4huc2BkSnS+IpMclrYmc
	L1f8Unf8YjVvlQ9Qd2k4LYJr8RfGWWeOnphk2aO9jRvy/KQD2RmgOH/SrE9yYd0=
X-Google-Smtp-Source: AGHT+IHlxXQHOoIG5Xms+dbKMTaH/vArkSFDYv8NHwvurq0I3OqBwEKhWmO0dZKyqjO8q42AqL7AQQ==
X-Received: by 2002:a17:907:f14d:b0:a7a:9760:9aec with SMTP id a640c23a62f3a-a866f8c3418mr450021966b.43.1724321068912;
        Thu, 22 Aug 2024 03:04:28 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a9b6sm96500966b.179.2024.08.22.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:04:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 22 Aug 2024 12:04:34 +0200
To: Simon Horman <horms@kernel.org>
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
Subject: Re: [PATCH 06/11] clk: rp1: Add support for clocks provided by RP1
Message-ID: <ZscNMk3hBWs5yKTH@apocalypse>
Mail-Followup-To: Simon Horman <horms@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
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
References: <cover.1724159867.git.andrea.porta@suse.com>
 <a378cc652b7e92b4022141dd2f20711e1771eb72.1724159867.git.andrea.porta@suse.com>
 <20240821131757.GB6387@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821131757.GB6387@kernel.org>

Hi Simon,

On 14:17 Wed 21 Aug     , Simon Horman wrote:
> On Tue, Aug 20, 2024 at 04:36:08PM +0200, Andrea della Porta wrote:
> > RaspberryPi RP1 is an MFD providing, among other peripherals, several
> > clock generators and PLLs that drives the sub-peripherals.
> > Add the driver to support the clock providers.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> ...
> 
> > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > new file mode 100644
> > index 000000000000..d18e711c0623
> > --- /dev/null
> > +++ b/drivers/clk/clk-rp1.c
> > @@ -0,0 +1,1655 @@
> > +// SPDX-License-Identifier: GPL
> 
> checkpatch says:
> 
> WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/...
>

Alas, the system on which I executed checkpatch was missing git python module,
so spdxcheck.py wasn't working properly, sorry about that. Fixed in the next
release.

> ...
> 
> > +static int rp1_clock_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct rp1_clock *clock = container_of(hw, struct rp1_clock, hw);
> > +	struct rp1_clockman *clockman = clock->clockman;
> > +	const struct rp1_clock_data *data = clock->data;
> > +	u32 ctrl, sel;
> > +
> > +	spin_lock(&clockman->regs_lock);
> > +	ctrl = clockman_read(clockman, data->ctrl_reg);
> > +
> > +	if (index >= data->num_std_parents) {
> > +		/* This is an aux source request */
> > +		if (index >= data->num_std_parents + data->num_aux_parents)
> 
> It looks like &clockman->regs_lock needs to be unlocked here.
> 
> Flagged by Smatch, Sparse. and Coccinelle.

Ack.

Many thanks,
Andrea

> 
> > +			return -EINVAL;
> > +
> > +		/* Select parent from aux list */
> > +		ctrl = set_register_field(ctrl, index - data->num_std_parents,
> > +					  CLK_CTRL_AUXSRC_MASK,
> > +					  CLK_CTRL_AUXSRC_SHIFT);
> > +		/* Set src to aux list */
> > +		ctrl = set_register_field(ctrl, AUX_SEL, data->clk_src_mask,
> > +					  CLK_CTRL_SRC_SHIFT);
> > +	} else {
> > +		ctrl = set_register_field(ctrl, index, data->clk_src_mask,
> > +					  CLK_CTRL_SRC_SHIFT);
> > +	}
> > +
> > +	clockman_write(clockman, data->ctrl_reg, ctrl);
> > +	spin_unlock(&clockman->regs_lock);
> > +
> > +	sel = rp1_clock_get_parent(hw);
> > +	WARN(sel != index, "(%s): Parent index req %u returned back %u\n",
> > +	     data->name, index, sel);
> > +
> > +	return 0;
> > +}
> 
> ...

