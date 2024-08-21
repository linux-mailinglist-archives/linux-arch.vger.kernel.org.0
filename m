Return-Path: <linux-arch+bounces-6403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248229597FF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43151F230E8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014E158D8F;
	Wed, 21 Aug 2024 08:49:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7F1A2873;
	Wed, 21 Aug 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230164; cv=none; b=keCMcmw2LyPzVp/7DncRP4/u3Xe8pqT4uq8J+kMg5ruSYsTejp4gUnf56YQ1BwCmjz87iiVpuFnEzAx6O7gwANAFeGybBnsT+Nxnnstrodt2OpQg185/5/oCyL/mI6kpkuJmZy24xiivwyrfuo1eDx111eFxl+IWmdPpgkkfvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230164; c=relaxed/simple;
	bh=LKr4rdH+xZbTu2yhcIA2OdvnxhvnxFtzzUi6nJEJfbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giy0f+OPjoarakTyzL+zV7UhQE89TCFi5li25Pnah+fdgvLuaOF/MaAOzyPVFOK5VAWkEhvCFspCOFOe7N8o+inDK5j8Adad+X+s1yePUYsAZJfohzkKGuOEOgNoFM5cPGYvogIOaH8ALthBxmAs6z/TjJs42vcHPSizL+XmUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371a13c7c80so293893f8f.0;
        Wed, 21 Aug 2024 01:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724230161; x=1724834961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukrxdYKGocvbe6s+bvnlsPSVVnh0A9nJ4+Mt3mqrxjs=;
        b=ar36/ReeTmZV99doht/ytOHnjdGT3R83BUsbReYcun0zI55XBVZdLA8LkyUXgDo1wx
         kka6gEbbhegNhymlN1HDe/+ZYKwA6WfPoXinO3zbgKsjCujmifOg6Ww84N8AYMIl6dQF
         IX1rS+p6S82jV+DOWz9DUuzX/pJLw0hvyE6r0PJ9lMxO84xj08e3NC28iUSZAOqJywiX
         ONC1Ew+JArDMYrKTYZRhIV5orZh7DVQR6ZLzKPnToQwwIcyHfai4LyykKbkfPgxeEct1
         hM0EiJFalXzIdKBlYufqrT7aKO6njcQtF2q1MvKNemKFeHvvkeBLAKFE0OJMwjaEBL4c
         z8gw==
X-Forwarded-Encrypted: i=1; AJvYcCU/+Sy1swCAOEUOmAum9ZNq6MhXQu/MfSObqSDLfZhg0kAI2Vu5gQtefbKpRhJMtBTWKOAnthmLLBom4Q==@vger.kernel.org, AJvYcCUVmLV5rEwjHUcEiBtfECM2uNsWjTHZgNeHpRvytqkxk6QQyag56nmLVNTcqWP4kG+rOvKdk5pDrX8+8Q==@vger.kernel.org, AJvYcCVYWcpmZ0PEvf0gLk5mh8we2/Q+j9j7H/34VsZIlRde4qudW5pwjnCrs6FJraNzRG3yAgRt87keACPqq8Nl@vger.kernel.org, AJvYcCW+wQ+3YcNtVI5geyoxHCe1f/HFwRIKzekZ3juO2irUI269KJ6ZHNEWBSL0TQudgj+B8Xpk/3FtM/zN@vger.kernel.org, AJvYcCX+TwTS+6tg4CxyJc7M0pXE+jQtzAuYpdHJJIU1F4S3XY6djRp/Ay1/q8xsKi2Dkegn6AousA4EeiNV@vger.kernel.org, AJvYcCX+WZ7YWCexmhtFS7K8FQk/dHJqcOFuobdMqD4bQwz+nSZgSENRzKT1Nl2Wb46t2Ujk/E4sU3tm@vger.kernel.org, AJvYcCXwDZc4l+Rbq57ZxO9Qp6e9y7iJNzJb9egLkorLJOj8JLr/soGnJw3RUqgTamxEJN++nT0wm0LYRLdz@vger.kernel.org
X-Gm-Message-State: AOJu0YwXae/TVXmKlhyFTO338UR7SNWdfMIEZcFRup9q3xoRAQZNyHln
	kD0zhJqlx5BX1XQugWvPXESL0wkoVWqIz0f4v3Vf4gZkDpu11Y8Z
X-Google-Smtp-Source: AGHT+IEzY+cggmVnYXPr8wlDLGWO82CX9mX5uhMUzAWJkxF4X7S6w6FHg8Ktq2bdplOPGiLT2xi4Qw==
X-Received: by 2002:adf:f70a:0:b0:36b:ea3c:5c00 with SMTP id ffacd0b85a97d-372fdd9a510mr842526f8f.9.1724230161018;
        Wed, 21 Aug 2024 01:49:21 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abef81a5esm17549115e9.28.2024.08.21.01.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:49:20 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:49:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 10/11] net: macb: Add support for RP1's MACB variant
Message-ID: <cfysm2r6sswmvrch34pk5dx4wum3rohcxdla7i5qoh6vizgklb@pk5i7nzlnp67>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:12PM +0200, Andrea della Porta wrote:
> RaspberryPi RP1 contains Cadence's MACB core. Implement the
> changes to be able to operate the customization in the RP1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>


> @@ -5100,6 +5214,11 @@ static int macb_probe(struct platform_device *pdev)
>  			}
>  		}
>  	}
> +
> +	device_property_read_u8(&pdev->dev, "cdns,aw2w-max-pipe", &bp->aw2w_max_pipe);
> +	device_property_read_u8(&pdev->dev, "cdns,ar2r-max-pipe", &bp->ar2r_max_pipe);

Where are the bindings?

> +	bp->use_aw2b_fill = device_property_read_bool(&pdev->dev, "cdns,use-aw2b-fill");
> +
>  	spin_lock_init(&bp->lock);
>  
>  	/* setup capabilities */
> @@ -5155,6 +5274,21 @@ static int macb_probe(struct platform_device *pdev)
>  	else
>  		bp->phy_interface = interface;
>  
> +	/* optional PHY reset-related properties */
> +	bp->phy_reset_gpio = devm_gpiod_get_optional(&pdev->dev, "phy-reset",

Where is the binding?

> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(bp->phy_reset_gpio)) {
> +		dev_err(&pdev->dev, "Failed to obtain phy-reset gpio\n");
> +		err = PTR_ERR(bp->phy_reset_gpio);
> +		goto err_out_free_netdev;
> +	}
> +
> +	bp->phy_reset_ms = 10;
> +	of_property_read_u32(np, "phy-reset-duration", &bp->phy_reset_ms);

Where is the binding?

> +	/* A sane reset duration should not be longer than 1s */
> +	if (bp->phy_reset_ms > 1000)
> +		bp->phy_reset_ms = 1000;
> +
>  	/* IP specific init */
>  	err = init(pdev);

Best regards,
Krzysztof


