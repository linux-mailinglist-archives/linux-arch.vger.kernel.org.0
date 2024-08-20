Return-Path: <linux-arch+bounces-6373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379E958996
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FF51F229FE
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6517E192B98;
	Tue, 20 Aug 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GOFbM3ej"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9171917FF
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164581; cv=none; b=IbJrii0gOPIDxp9a3xMf9pk+an2aor8HxdnjkTMpTM+dqmcnCBe8hSkCyNMWYjxUipre+iGF5LqytyQqCWO9b4y6jRPbZS7nMgu/XB5wjWAXhRLsjFxieCZfB+2z/vULfEkMzo5o5AFNLRxEs8hyMS0W6/a4SOW2hijOs7wEecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164581; c=relaxed/simple;
	bh=lmkX3X+lZfdLocHcy9uquvCuB7MX3sjbyBoHFtfeUIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhDJo2bFAg0LoTR3f6sr2QT3th53tva0ZEDkT5A/yMZAuaibxSUuRgeOClZSVyZs1nV1gQg1kiakR7nOCusaeazeI+ZfXn5gOYXT08x0YZLg9Q1qlEzQgJmdt4AHIJOuYf1u/h9C0CZHyKFMJU9PnywYs9fYCtz1rAmsFWuMIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GOFbM3ej; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so2092185a12.0
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164575; x=1724769375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xT6huOC6T7Yu7zfFRkWYs+RyZWH6K8VkXHaDH7bLRdw=;
        b=GOFbM3ejQrvqPnq3AQiItzlch4kDbEyor+mNzJTzIJ1Tdp5pM9qNbmhYh8YZJWYrcU
         a9NkZOO3tzPBotazYKDhjjhXKlAJ34B5tiTJqvbEyvCHD7kGqRBYfIpxCQkzu1+rzWrG
         jx70FKUmqrCkbPJF1smy8fFJyafehS4kHW089dDrtRLbzg792WlTgVdwegXi0OnIl33x
         IwadkE/9PWDo7MU7EA0yM6v6b+81CqrA5FQ7DyUySclAvW9y6SLGHEj2tiuHSTsClT+I
         cHS9BPpykW/LplwpQDZ47z5olZaYKFG/IE/56ZGr9q5lZZvZQItIYd+kpIFc+KYVCpH7
         OBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164575; x=1724769375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT6huOC6T7Yu7zfFRkWYs+RyZWH6K8VkXHaDH7bLRdw=;
        b=eJ9WyOChPn4ridTetLsSjgxATaGOMyGvWIFNs7NLzBvPXrVj2IwWVjp8yACTWSBreJ
         UkzeC9CaQc8S01dkRpxedg+7RoFvdhUqshGcNA1G2KZ/31jV5kL3JWq8ya6l9VYNvH/t
         aqZn12lq9hs+xkkkChqM0Pm6PmJCkVWWNvuf9MNQeWHW0XWJPcjkRw9hjImmvotRCRPA
         hM6OiaZIQ1g+3Csd1GBFZci9GozxBigP5+e2y//bbckUkAQH7WpQ02xW7YwwsWWOhZPa
         MzB5IKuqy+gV/zdUtFGN2b43BLQPWlXLW65wHEsfLjhina/PLL5l65I6oskegii+EQKW
         rgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSBkvx2Y6SgccMUwhVVRtNm/nGatojkVSc6oMWZf7o2+zHlNXlMFiDMdWNllFvf+YREd/kbhogpifY@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN4aIBHwl0IAPyeo8tdC6yRAbx6OVTVaJ/cNFY1Jfd4h0iW/g
	xd4zjvRUJ7R9orJzSF8//DYkp8KvKyqncmfjtww3dTXtm7vyEgAyIYTRNbJtbzM=
X-Google-Smtp-Source: AGHT+IGQKwDr2ogZrSzCgclLvBAiT9X7zYngYAlcDJL0KUFwXPaOBp69ElOzx3FbUUgrmqZUdz3wjQ==
X-Received: by 2002:a05:6402:520c:b0:5be:fadc:8707 with SMTP id 4fb4d7f45d1cf-5befadc893emr4836516a12.7.1724164574347;
        Tue, 20 Aug 2024 07:36:14 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc0817a8sm6821446a12.84.2024.08.20.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:14 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address parsed from DT
Date: Tue, 20 Aug 2024 16:36:05 +0200
Message-ID: <8b4fa91380fc4754ea80f47330c613e4f6b6592c.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_pci_set_address() function parse devicetree PCI range specifier
assuming the address is 'sanitized' at the origin, i.e. without checking
whether the incoming address is 32 or 64 bit has specified in the flags.
In this way an address with no OF_PCI_ADDR_SPACE_MEM64 set in the flagss
could leak through and the upper 32 bits of the address will be set too,
and this violates the PCI specs stating that ion 32 bit address the upper
bit should be zero.
This could cause mapping translation mismatch on PCI devices (e.g. RP1)
that are expected to be addressed with a 64 bit address while advertising
a 32 bit address in the PCI config region.
Add a check in of_pci_set_address() to set upper 32 bits to zero in case
the address has no 64 bit flag set.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/pci/of_property.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 5a0b98e69795..77865facdb4a 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -60,7 +60,10 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 	prop[0] |= flags | reg_num;
 	if (!reloc) {
 		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
-		prop[1] = upper_32_bits(addr);
+		if (FIELD_GET(OF_PCI_ADDR_FIELD_SS, flags) == OF_PCI_ADDR_SPACE_MEM64)
+			prop[1] = upper_32_bits(addr);
+		else
+			prop[1] = 0;
 		prop[2] = lower_32_bits(addr);
 	}
 }
-- 
2.35.3


