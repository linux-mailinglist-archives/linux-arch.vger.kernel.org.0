Return-Path: <linux-arch+bounces-6402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37F9597F6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C41C21521
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBC1CF2B2;
	Wed, 21 Aug 2024 08:47:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314E1BF80E;
	Wed, 21 Aug 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230033; cv=none; b=T4SDtLza/HlWXJb1PJAWqGOcsxUA88F5Wca7+cI3GITX10HgQEqnh/0xM5X0EABn5J3YMW5xk+sqMNBYPcmGGo7X24LfcnhYFNsbscm+8LxScK2wEpjiEmoLQHo8T7fkxC2eJ4+dLzbBmaJ/kqLMduavRTmyajY7adqrUP8CN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230033; c=relaxed/simple;
	bh=M5rcnyo1PU9bHEGof4iD+77GYJ9+Nq6f2gJOQCjGazk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3MB8UtYljmviiKZJug2CWtvXRcSIa0HAJcH2oGv6VT0fi+hAGc5D10P5uzwOjd1pUKSLZjYiyQfWYKym7uegfmrByM2fJYuqJ2yDwEBUwIhjU0zmgbf20kgxUoi7xNoXMUZdtKLl0dSPRTclFkB53zmz2RyLQKhdrFjHxRMQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso54218085e9.1;
        Wed, 21 Aug 2024 01:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724230030; x=1724834830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buvMEH6CKDBTb0PBuEIhwuqwnHLMUI4vteUmT5/9VxA=;
        b=YLWkfyJ1geyN7y/Yqwxe43GRGC4qxCKkNsv24HBILSlp+GeWPpeAwB2BPihWVLM3TY
         +rkZhdZ6SAs3WI3Ae/0V4J/7UM0Wi4NK5olbjDOLz0v8oBHGlbNEdIPg/ViGy9YI+IK0
         zBprL0xqP3muCFcd2sHIWqN1gKdCsujs1ztAv31/f7zgOfaRpAoHD3+MeXYzicFBuIOd
         2qKCrjd93RC6CpHS3hKtMPajACKPSQPyO399HdNSpTom2x/Ehxlz8iqyEr6fqLiY58s0
         I10ynsKSGtyPrIslMDgwdR40Mxejdx9zt/vOKYDeQeqtnoJGT1XMmpRzdDTcfMi462Ef
         /B8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2avUPG7qTQb91P2/y5i7oQvbb1BAWvY1NFtCrX3is79e7OmUdzUZh8rxJXPNKwchXl9ey/5as@vger.kernel.org, AJvYcCV25a//ttMCZ9/GiqNJkO81vpKiCQjVJTn0vVrJ61034xlBKFjbcHVOf47rdfFZF1y+oomigwkKg9MsjJDx@vger.kernel.org, AJvYcCViPumvW3WhmFfYNDkv17UAPPuAXAvj2o9iYauLTnRPWBVzXb7aNzoGxomMU8b6dwIr/Ib0iWcKPdyo8A==@vger.kernel.org, AJvYcCVzL2PeBR1yU5i7zbRDJCjzpTX+O9295qFSchbzlniXjgL0Ry6TW0ypiiRft/6d0BT0eNnFYjuNZaJW@vger.kernel.org, AJvYcCW5RJ1RP1nDFBJG2SehSA3flXOq7efoQQdiZqNow/ysFf1UF+nZ0C6FI2gVA5MvLN+9i3cMizqjZz6h@vger.kernel.org, AJvYcCWuVCebwbNjhuOakZD9GylpEYpWF5m3Z00ngERunQyzWLOHEVffuO5REDF0XBhkTAcHqGpDEzQZzhvZ@vger.kernel.org, AJvYcCXMsDz18VfwU7i93mmM06N05wWg4bwaf8PiJROWZxHX0kLEG1AOkbAl6dgD+UYPD6X3X29bi0jQZtgdhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx01kkeAA07QqTnM+TPoojM/bNF8GqG525fYl60MR7PQ3L99En
	Qp2fwUTjc08Pr100EinENH00lMeW+Ksnyb6hZt7fMUnHBekWeEpO
X-Google-Smtp-Source: AGHT+IGBO+QNtZJ3mTksxnSEne41y5PqhbjnZoNZMEMBIcMVpO4wBIutfr6rIx63hGxxAnnlKwhVSA==
X-Received: by 2002:a05:600c:3d13:b0:426:55a3:71af with SMTP id 5b1f17b1804b1-42abd263ee4mr10630895e9.33.1724230029698;
        Wed, 21 Aug 2024 01:47:09 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abf0179f7sm17685555e9.47.2024.08.21.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:47:09 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:47:06 +0200
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
Subject: Re: [PATCH 09/11] arm64: defconfig: Enable RP1 misc/clock/gpio
 drivers as built-in
Message-ID: <woewl6x7zyetuv3lc22kkmk2pptbfgoribtk6ziqmwjqxnm6rl@npv7tkquzqym>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <7ec76ec9b10ef1d840a566dab35497bf2d40b437.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ec76ec9b10ef1d840a566dab35497bf2d40b437.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:11PM +0200, Andrea della Porta wrote:
> Select the RP1 drivers needed to operate the PCI endpoint containing
> several peripherals such as Ethernet and USB Controller. This chip is
> present on RaspberryPi 5.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d32fca64996..e7615c464680 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -606,6 +606,7 @@ CONFIG_PINCTRL_QCM2290=y
>  CONFIG_PINCTRL_QCS404=y
>  CONFIG_PINCTRL_QDF2XXX=y
>  CONFIG_PINCTRL_QDU1000=y
> +CONFIG_PINCTRL_RP1=y
>  CONFIG_PINCTRL_SA8775P=y
>  CONFIG_PINCTRL_SC7180=y
>  CONFIG_PINCTRL_SC7280=y
> @@ -685,6 +686,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
>  CONFIG_SENSORS_SL28CPLD=m
>  CONFIG_SENSORS_INA2XX=m
>  CONFIG_SENSORS_INA3221=m
> +CONFIG_MISC_RP1=y

Module?

>  CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_DEVFREQ_THERMAL=y
> @@ -1259,6 +1261,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
>  CONFIG_COMMON_CLK_FSL_SAI=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_COMMON_CLK_PWM=y
> +CONFIG_COMMON_CLK_RP1=y

Module?

>  CONFIG_COMMON_CLK_RS9_PCIE=y
>  CONFIG_COMMON_CLK_VC3=y
>  CONFIG_COMMON_CLK_VC5=y
> -- 
> 2.35.3
> 

