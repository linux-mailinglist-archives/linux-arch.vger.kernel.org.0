Return-Path: <linux-arch+bounces-6429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D995A36A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E88B22B54
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E11B1D68;
	Wed, 21 Aug 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ggrxP9aL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410F13635B
	for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259768; cv=none; b=QsNGxXOl7KVvDC5kOr+UnZ+2Xy5o8cint8ga+I/LHdS41/fQFcqJBftr84FgJ5PNXZ6A8TgX7YGIdXN+Nn0cUYLfbsvCqk3IsCfK000A/BhaZrR1486wpbTqjRwmFfu+0f5XMaWhNJ0MYirekdexsGZ4Wu7v4TUh8QI7FYjyN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259768; c=relaxed/simple;
	bh=cw9bJs+xqcXZNyScXsvQUU+pqCUtxyq+6IrvkmMyU6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZOfDF6JqJ2Pav3BiyfrRc7N5mawEH6fHiYqvgpCUq2I+hknqkvydYQjDEcB6y+FXNl5PmRblSNIo4zG9mJj7HbJ+7vLuvgsTYdwh4E4JT1RMPAWuK3iBHkfHS31QGbqnMffuwkemb1O1cxRVRGdDNaPSwusVRRBKumb1Vaf48ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ggrxP9aL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf705959f1so8755196d6.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724259765; x=1724864565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq94Qm6ZPacZgTXtsJjDDEhseS8HiVRXtfMMRotZvfU=;
        b=ggrxP9aLya+MJwLZs6ACvxgNh1Gt01v+KxYZoLSOdFDHL3PBUJBVS0MH0PDdjG4pvF
         Qh5Wg8Go0HIOznRXa8bwris+kjebvpwzuV8SxUkQS1iBRxrfgJ0Rz/j9buID+oPJstUT
         Jcq2KYmxSQCsBWMhD/cbfqplZa5vfe4rRr84w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259765; x=1724864565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq94Qm6ZPacZgTXtsJjDDEhseS8HiVRXtfMMRotZvfU=;
        b=fbKTUtyyePozwtMtW+AeBJgnnCfLDWvfaP7m8kAUy+Hh/BcUBHVnQ3/TZ994WlCbkF
         zLGMZbjfGnZws3UJ1XfCpcrFZ7+1h1ZJkZJYcVuYOD3gCAbX61ghoBP9L8jrA88VV659
         oHIE3TMmrJ2UutIYJERkUy5Hc91mfgs2hhCWL2ovAs7k9+KoLeLwz0VRdDhOBEMUEcVr
         22PDXcZgQYfEk6FJS7N3uCRo405tHvePXlPzsoQC/MhZpNZnMAh8zMuXSO6gVT59vkSH
         OSPTJ12al0ozXSUjRV+c/7Njw1kPOzfATF66N7qGqb3ZlASqyRIxNHUeHd0xJbpypVDc
         EY/g==
X-Forwarded-Encrypted: i=1; AJvYcCW8SaOJuQGmGpmNsnchFEyF5gtFJoc7R5umz+L07+ggJYKdjdbOzjdreASf5BcvukFtZu7xrmG3XeZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcO1syatR/PEVWTHHW1Na/bVTqNOTI6utI5NXQCbfzWZb7V8j
	n83UmlRSDkwDC1RqaSNNNMv8CAK3f48sOCircZWNZOx3Wt9h2/rt5I+KfUNbdg==
X-Google-Smtp-Source: AGHT+IEjxwxYxIEnylwCzeT1GUQ7/N5LveBGkYrCmL/PzJnTVxIVH/b8mImwCW+ynbJrXjzvA/Ti0Q==
X-Received: by 2002:a05:6214:428e:b0:6b5:d95c:692d with SMTP id 6a1803df08f44-6c160c6de82mr5740656d6.13.1724259764561;
        Wed, 21 Aug 2024 10:02:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe4fc98sm63388126d6.71.2024.08.21.10.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 10:02:43 -0700 (PDT)
Message-ID: <e442c254-6bd1-4724-83f7-e3690d756ac4@broadcom.com>
Date: Wed, 21 Aug 2024 10:02:39 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] arm64: dts: rp1: Add support for MACB contained in
 RP1
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
 <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>
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
In-Reply-To: <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 07:36, Andrea della Porta wrote:
> RaspberryPi RP1 is multi function PCI endpoint device that
> exposes several subperipherals via PCI BAR.
> Add an ethernet node for Cadence MACB to the RP1 dtso
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   arch/arm64/boot/dts/broadcom/rp1.dtso | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> index d80178a278ee..b40e203c28d5 100644
> --- a/arch/arm64/boot/dts/broadcom/rp1.dtso
> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> @@ -78,6 +78,29 @@ rp1_clocks: clocks@c040018000 {
>   							       <50000000>;   // RP1_CLK_ETH_TSU
>   				};
>   
> +				rp1_eth: ethernet@c040100000 {
> +					reg = <0xc0 0x40100000  0x0 0x4000>;
> +					compatible = "cdns,macb";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					interrupts = <RP1_INT_ETH IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&macb_pclk &macb_hclk &rp1_clocks RP1_CLK_ETH_TSU>;
> +					clock-names = "pclk", "hclk", "tsu_clk";
> +					phy-mode = "rgmii-id";
> +					cdns,aw2w-max-pipe = /bits/ 8 <8>;
> +					cdns,ar2r-max-pipe = /bits/ 8 <8>;
> +					cdns,use-aw2b-fill;
> +					local-mac-address = [00 00 00 00 00 00];
> +					phy-handle = <&phy1>;
> +					phy-reset-gpios = <&rp1_gpio 32 GPIO_ACTIVE_LOW>;
> +					phy-reset-duration = <5>;
> +
> +					phy1: ethernet-phy@1 {
> +						reg = <0x1>;
> +						brcm,powerdown-enable;

Undocumented property, and I would like to understand why this needs to 
be specified in the Device Tree? What model of Broadcom Ethernet PHY is 
being used here?
-- 
Florian


