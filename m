Return-Path: <linux-arch+bounces-6428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A873C95A35C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC11A1C20D8A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D291B1D6B;
	Wed, 21 Aug 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ey0bjA0s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E181AF4C9
	for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259697; cv=none; b=dyjsRvRKpU2QJMWoIJU2YNLLIRAveY8y+QllxMaCPr0p/D4ivL103hpb3rpH1ynejYO32j/aZ3ApwzTryx/su8pS9W9ufkMqdGd8935yJbR0ceqopGsBS1qdSnLh5EgxX60e3qB2Rgzw8M5THIjcsJN8p2wi/zXM1HyuZ77n4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259697; c=relaxed/simple;
	bh=4dYtH4U31qHxoWZiCOzczVFUvv/JyGm+NnF5gYr0p1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ndNKVvfixCcqNW4yx/QJ3n/USYj16WxtwGn4Qm9FgKvp/2hlzlijgCmcgdImy3Pf5gLwLjaoqMqlvQvZQmaJJjhTyFFaZESKOw740AAZpvWNLO+X/RHpcFfQG0OVmrQP13pprIsThuSdERsY7XwaOkdhA5H+Kv24m8agbUFjjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ey0bjA0s; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf953cb5d3so20296006d6.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724259693; x=1724864493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exJT+ZV4yPGmtBlC0PJbj8K2B4aeAUj4JcsLcu7ZSHg=;
        b=ey0bjA0sRfbduofEwpU8qiyE9plWOyfAppQo/frEV1wYfbbe+/Jf5VuCBydcFm+M4q
         uQKZWiOZrP4wu1VMTsRufGrfkprgGl3OryDuJMIqe4GC2JGxHZyxzqfw1WD1/cmhllww
         6wMo8MVtOdR1u4cv2pWIwOW/1D+qTiNmKG5+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259693; x=1724864493;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exJT+ZV4yPGmtBlC0PJbj8K2B4aeAUj4JcsLcu7ZSHg=;
        b=YwgnjdgGEFg3mEmsp0rSqRzpZCVsIcYNU2p0mEp/Zhh/TMvMLXEubhR+77gSBhw8os
         0x1UdDsL/fVglY2AlEdZbJ02/itB1dwNVG2q7t5ekARhfplqO2xR30CoPyrxq3dL+kKf
         UBALVhCNirOj5DVG9l2bad0uZGxFOb1it7h7vnf1F/Vdt3gCcd4Mb7enf8JCB7kR8cxD
         0RJWYsSHeWos6Pi/sn3NFSZSY1qBjpBze7OW9qG1BER3wz0h1+euI/W7jLpmTo8sdpWe
         LQ8ru7W1j2rACXeMIFzCNvmUbEfADXjF1lwxBIgTB6d2qpZAU1awH0KJePX2803Uc32F
         tTug==
X-Forwarded-Encrypted: i=1; AJvYcCVSMLF5zEqH0L7bBv2XSoLqXmY28DCCJPm9iLyUpddf+seuqfunHoopJTaZHlTq/8/b2enW/7KcNI/0@vger.kernel.org
X-Gm-Message-State: AOJu0YyuE1xV5LSC80Y37/qGJm/mcZfsyF2YLy9NzVR3nnjb/NDys3Kk
	jOQ/9s+JH1XnCal5dXgZ4PtqOGlfEOaEtHYzVO/UhEy0P7wzefWhiFZY+U7lHw==
X-Google-Smtp-Source: AGHT+IEcf5j9ZU2KA/mfYlqLlBtTaasVuWTNEJvsSLdgOYVrSFlA0Ol5aqfVqe99xcRCOICKogXkvA==
X-Received: by 2002:a05:6214:3c9d:b0:6bf:9aa5:c3b0 with SMTP id 6a1803df08f44-6c155dbb500mr36517976d6.33.1724259693005;
        Wed, 21 Aug 2024 10:01:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe1bb00sm63540126d6.55.2024.08.21.10.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 10:01:32 -0700 (PDT)
Message-ID: <c0b904d8-073d-47ec-9466-28ae3a212dac@broadcom.com>
Date: Wed, 21 Aug 2024 10:01:26 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] net: macb: Add support for RP1's MACB variant
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 07:36, Andrea della Porta wrote:
> RaspberryPi RP1 contains Cadence's MACB core. Implement the
> changes to be able to operate the customization in the RP1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

You are doing a lot of things, all at once, and you should consider 
extracting your change into a smaller subset with bug fixes first:

- one commit which writes to the RBQPH the upper 32-bits of the RX ring 
DMA address, that looks like a bug fix

- one commit which retriggers a buffer read, even though that appears to 
be RP1 specific maybe, if not, then this is also a bug fix

- one commit that adds support for macb_shutdown() to kill DMA operations

- one commit which adds support for a configurable PHY reset line + 
delay specified in milli seconds

- one commit which adds support for controling the interrupt coalescing 
settings

And then you can add all of the RP1 specific bits like the AXI bridge 
configuration.

[snip]

> @@ -1228,6 +1246,7 @@ struct macb_queue {
>   	dma_addr_t		tx_ring_dma;
>   	struct work_struct	tx_error_task;
>   	bool			txubr_pending;
> +	bool			tx_pending;
>   	struct napi_struct	napi_tx;
>   
>   	dma_addr_t		rx_ring_dma;
> @@ -1293,9 +1312,15 @@ struct macb {
>   
>   	u32			caps;
>   	unsigned int		dma_burst_length;
> +	u8			aw2w_max_pipe;
> +	u8			ar2r_max_pipe;
> +	bool			use_aw2b_fill;
>   
>   	phy_interface_t		phy_interface;
>   
> +	struct gpio_desc	*phy_reset_gpio;
> +	int			phy_reset_ms;

The delay cannot be negative, so this needs to be unsigned int.

> +
>   	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
>   	struct macb_tx_skb	rm9200_txq[2];
>   	unsigned int		max_tx_length;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 11665be3a22c..5eb5be6c96fc 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -41,6 +41,9 @@
>   #include <linux/inetdevice.h>
>   #include "macb.h"
>   
> +static unsigned int txdelay = 35;
> +module_param(txdelay, uint, 0644);
> +
>   /* This structure is only used for MACB on SiFive FU540 devices */
>   struct sifive_fu540_macb_mgmt {
>   	void __iomem *reg;
> @@ -334,7 +337,7 @@ static int macb_mdio_wait_for_idle(struct macb *bp)
>   	u32 val;
>   
>   	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE),
> -				  1, MACB_MDIO_TIMEOUT);
> +				  100, MACB_MDIO_TIMEOUT);

Why do we need to increase how frequently we poll?
-- 
Florian


