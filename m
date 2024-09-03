Return-Path: <linux-arch+bounces-6963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49996A3F8
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A8B287061
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DBC18BB8E;
	Tue,  3 Sep 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WmFFff2k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67B18A951
	for <linux-arch@vger.kernel.org>; Tue,  3 Sep 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380107; cv=none; b=s4+n2A04yc8hcBeX5hbim2/Xjg/n9O8w1K6RfHLK9DL2uhWWen3f1mMFG28Nkhn3p1CdmpX4b6rRvL4LLBPbfivqV93z0l8BHgCos2p/ah7B2F4NO607J9U+vNtJN18NzzBWg3sZtp4fBQVlc6b4nbZscDiVmGxIjBIcOoLF/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380107; c=relaxed/simple;
	bh=xpPrjjx3C5+Im8uDKPe6tjHcImbiqGdfdOEgJ6hTna4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7G7TOm46c6cZVsdJaWVUPE5yCzyUUWDm+xhvqe2OsWpi/tE2/jpzGdfs/vhKmoPCi7oC7jmhryoSSZMFGlsjk2CCNlPc6ugQXmMJTSFT2lk7jWypuZqV+m6+YWBJnbKzAeSMydzKKJTUQszF83QNXVKnJmzq0ISQsnvBAMbee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WmFFff2k; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a8a1d78e7b0so163447166b.3
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380103; x=1725984903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ujcJQ5WbiK5TK1a1sgf7j5ujXkTQVZFXM9n+2iP5G8w=;
        b=WmFFff2kFIq19MtQaDjm0FzF2D+n4UmBArivKNenpVoyPiaLTVuuoy/2JRdmVHz05u
         Lqa4vliOXLpIra5yAWbRIRmH/gr73eNVqOuCZmERDdoW4IBJPAW0sYaVGWss4Y3rKkFr
         4krm7cnvbgu1nkic+2VZPaHyF42IWfbWvSKSNHgM6O3W1GyyexRpDg7m2fL5vczsU6T9
         rrPJgADQIB4TeWtAEmnA82LaI4PPec7TQ4J02+Yu8Ger2/dtigf3afQhVAjjOCTzdvv+
         35EMIx1mozZG7cBMF6y4hcXC4tVN306+ThGE/zCgjgLD3OTRWnpd8TJymP+El+OaQLAH
         PeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380103; x=1725984903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujcJQ5WbiK5TK1a1sgf7j5ujXkTQVZFXM9n+2iP5G8w=;
        b=fJKItpulcCmpZvp/oikXr9RDUtDV3PEmru9aAu85QmfeaOe8eDNVlqgskPnaZltFr2
         t1XPHOBe+de7bi7DBuNIZe0yYKfUHvUFIqh3pnfk7bDdQM4Css4GcZJFP5CS3p2CVB9y
         ZZa7cwW+dKhdbg+5eSY73l+nC+tula6HBlOw4axhKZwfAf+AHSvucL/KWQA2gOgj9cwH
         i5X585zBc4oaPHkma3/PVyCgzhMulgXD1RgOW6lVKLBfQl4X0TJ3CiGrqsrlzHr3V3LB
         XlvNQ1DWjTLxSaF8C1uTM3mnR1UDPioz46MWYMODcRNIfrabk0kuTo6bk0f1BGIiLSDc
         Tp6w==
X-Forwarded-Encrypted: i=1; AJvYcCWgBL7xFPlLV8d7VCR5hnMxf+lXjFlKwfsgIy1xv85XzIxnHPz+CJms3WLjBhM5tLxUCLOjBgAShMuv@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEV0VJP0DeRrBuZp+4J6aRF2nlBwcFi90dLLgomnrDes3DZ4A
	9lhUj2yE4qhseD28KmIPJz3ABu2bfIwc3PAE2miRR4it6y2N6K+ajUKSWnGpRng=
X-Google-Smtp-Source: AGHT+IGOVI/KlbnVkPKcUFB/WP4ky/V34Mnqxzaki61Es6M5ZEdZH9hu90OMWXXvI1MZc9xKoKdrvw==
X-Received: by 2002:a17:907:d08:b0:a86:6d39:cbfd with SMTP id a640c23a62f3a-a89fafad393mr618619866b.57.1725380102711;
        Tue, 03 Sep 2024 09:15:02 -0700 (PDT)
Received: from localhost (host-80-182-198-72.pool80182.interbusiness.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a1dbfba91sm145366666b.225.2024.09.03.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:15:02 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 3 Sep 2024 18:15:09 +0200
To: Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <Ztc2DadAnxLIYFj-@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org>
 <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
 <ZtBJ0jIq-QrTVs1m@apocalypse>
 <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
 <ZtChPt4cD8PzfEkF@apocalypse>
 <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>

Hi Rob,

On 14:37 Fri 30 Aug     , Rob Herring wrote:
> On Thu, Aug 29, 2024 at 11:26 AM Andrea della Porta
> <andrea.porta@suse.com> wrote:
> >
> > Hi Rob,
> >

...

> 
> I think simple-bus where you have it is fine. It is really 1 level up
> that needs to be specified. Basically something that's referenced from
> the specific PCI device's schema (e.g. the RP1 schema (which you are
> missing)).
> 
> That schema needs to roughly look like this:
> 
> properties:
>   "#address-cells":
>     const: 3
>   "#size-cells":
>     const: 2
>   ranges:
>     minItems: 1
>     maxItems: 6
>     items:
>       additionalItems: true
>       items:
>         - maximum: 5  # The BAR number
>         - const: 0
>         - const: 0
>         - # TODO: valid PCI memory flags
> 
> patternProperties:
>   "^bar-bus@[0-5]$":
>     type: object
>     additionalProperties: true
>     properties:
>       compatible:
>         const: simple-bus
>       ranges: true
>

Hmmm.. not sure how this is going to work. The PCI device (RP1) will
havei, at runtime, a compatible like this:

compatible = "pci1de4,1\0pciclass,0200000\0pciclass,0200";

that is basically generated automatically by the OF framework. So, in the
schema you proposed above, I can put something like:

properties:
  compatible:
    contains:
      pattern: '^pci1de4,1'

or maybe I could omit the compatible entirely, like in:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-iommu.yaml

that seems to refer to generic compatible values.
In both cases though, I don't see how these binding could work with
make dt_binding_check, since there's no compatible known at compile
time (for the first approach), or no compatible at all (the second
approach).
Is it intended only as a loose documentation?
Or are you proposing that for a future new bus (hence with a new, specific,
compatible) that could be described by the schema above?

Many thanks,
Andrea
 
> There were some discussions around interrupt handling that might also
> factor into this.
> 
> Rob

