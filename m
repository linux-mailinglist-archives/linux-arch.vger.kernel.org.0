Return-Path: <linux-arch+bounces-6804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CD9643B8
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BDC283D11
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90841946C4;
	Thu, 29 Aug 2024 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gToss/rZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97851946BA
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932915; cv=none; b=lGk22XcS8VTuwtNN+DEm4ugM++IrQD+frRnDJX/DjVtYJ9nO+Bdpb/Ai1H/o/4iOawwlaknc1ZUugq6Dra/28n3eRHvoZYLFeAbihej8JGSfKtuL4eVHJ/gUJaXBv6w76UsI07Q61VQA5L1twvNSRu/l7vh4XAfnCv0D1b4vjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932915; c=relaxed/simple;
	bh=fOZO2d20iA45ijbTFXi/g1LkvqA+AHUmsj+CK1eEIxw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa6Se8b9l8YfLe3KTopcEPstw0PtpVHJHQ0bV+6mogSUfSHZuvsHhtkVWDR0kNpy/EF8GHmVZR4hu9UqqZ6+dw6+gV7tdvWxOTnJ5FUUPkouHR8vG19GoiXRMo0ir4hIBCGIi4o4XvK06EmWeY0JBki5W62E3ZaQv1ttot8wubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gToss/rZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8696e9bd24so65298466b.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724932912; x=1725537712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXBtr/JbiSQG7W9JfMUYCtQfQyKUiftjthV/2nojugU=;
        b=gToss/rZvgKVjfAPyacL/q76YmsCND4RSc+aZ2fGN9apgKW2KWpDoeRDWPAZnSBlqQ
         mIxSU8x1ZPW//YSICJDua82zbgukZ9NzqnHfc69WdqzKHpZLKAYOnQCBbxwP/hRyGOyZ
         m1+Pr4NezMRbmuARSjLinJrBWmlBPkR1u8hUIvJKA0RmcZ59bxkDMydo8nXjE7AcNQ9t
         2FFoSazdfqV3ibXedxh3OzfH8Y4+9cvckn/uyvxXFZL7mqsyS3w6jj3V/XdRH/Eb/xG6
         k4EPzxy2RvVDMFFyv98ukloFIGKNWasVr5iKaaZ4dE+LL8cSlp9OtJyDMuwLxLlPyGQA
         qngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932912; x=1725537712;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXBtr/JbiSQG7W9JfMUYCtQfQyKUiftjthV/2nojugU=;
        b=fuufhHy+Adgjn5T8YJ8smQtn41+bceRB71kUeY5wTdVyORs2CJmNWoa0ue1SGZ69B+
         5L1ygVg+3VPtNkFD1PNhG3AMhtD61+N+bsT3X46gwXCgi0Qi8oTwvWQkX8+73FXot/xU
         XW/CXpABi6OMCkajIYk6b/ULkKaE9iqw97zqyVPA7yXlB2ifcSmqZnsYPdioRbS8x6FI
         8v7FusuaNbdlr57YcoMkkZOHcJdIABXo3tVOsW2RZbn7W8nhqRKn5Et6PXGjsJZyrxsB
         OU3YPQSTkU9hYW3oThPOQbODozUI041GkrXZ6xo/tFKrZBYEuNiSy35byGW19tnxvMhD
         w3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCV149h0cX507n0j4Rga/0JPMxK/3wfY9KGP/CRBzXIZcXr10iNUxjmLQNtxnyIfznf1XZ7HHdfH4Q9F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22IAntNtCIUriA6d6pkefQc1OxvOzydZ9G6CefAKtP4+rxT1Q
	fpqCn0CP6+lFRSUNCAtwjD1xrB/RsVnujbOT6bNVUy0qk0tpw3b377dt1oDnrpc=
X-Google-Smtp-Source: AGHT+IFsyk0IWnaZFMb265yPeWvESMoqgeE3DSP8XvW62AVSUHg1bVi4x43hO0c3ITnEgvBmjx2LDg==
X-Received: by 2002:a17:907:9708:b0:a80:7ce0:8b2a with SMTP id a640c23a62f3a-a897f84d44cmr193846766b.19.1724932909698;
        Thu, 29 Aug 2024 05:01:49 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021960sm71432166b.79.2024.08.29.05.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:01:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 Aug 2024 14:01:54 +0200
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
	Lee Jones <lee@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a
 DT overlay
Message-ID: <ZtBjMpMGtA4WfDij@apocalypse>
Mail-Followup-To: Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
	Lee Jones <lee@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
 <45a41ed9-2e42-4fd5-a1d5-35de93ce0512@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a41ed9-2e42-4fd5-a1d5-35de93ce0512@lunn.ch>

Hi Andrew,

On 15:04 Thu 22 Aug     , Andrew Lunn wrote:
> > WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> > #673: FILE: drivers/pinctrl/pinctrl-rp1.c:600:
> > +                               return -ENOTSUPP;
> > 
> > This I must investigate: I've already tried to fix it before sending the patchset
> > but for some reason it wouldn't work, so I planned to fix it in the upcoming 
> > releases.
> 
> ENOTSUPP is an NFS error. It should not be used outside for NFS. You
> want EOPNOTSUPP.

Ack.

> 
>  
> > WARNING: externs should be avoided in .c files
> > #331: FILE: drivers/misc/rp1/rp1-pci.c:58:
> > +extern char __dtbo_rp1_pci_begin[];
> > 
> > True, but in this case we don't have a symbol that should be exported to other
> > translation units, it just needs to be referenced inside the driver and
> > consumed locally. Hence it would be better to place the extern in .c file.
>  
> Did you try making it static.

The dtso is compiled into an obj and linked with the driver which is in
a different transaltion unit. I'm not aware on other ways to include that
symbol without declaring it extern (the exception being some hackery 
trick that compile the dtso into a .c file to be included into the driver
main source file). 
Or probably I'm not seeing what you are proposing, could you please elaborate
on that?

Many thanks,
Andrea

> 
> 	Andrew

