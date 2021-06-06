Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197EE39CFFF
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFQ3j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 12:29:39 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37832 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFFQ3i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 12:29:38 -0400
Received: by mail-wr1-f50.google.com with SMTP id i94so9568790wri.4;
        Sun, 06 Jun 2021 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LMS6521uwLvF3d0VH9aHVTLaSPCmp9aqfX/Cw2Qkt8=;
        b=qbMma+/EYBI89XYXH6O5Gn0B1ZxLNxhf+QnPVywlVhDpm4TQtWpC0b58caEwBCMnIC
         rojWchC/QzXkvoo9WoG7CkI/9FQOI/ImTnp8KF9xJ6yXQPr8BDjhDq21NL0nfbd2sizR
         l6tqoyurBVltuw8jmKvNFidWuqunqEb0N01jo5k/NUrcQOzJHlE3WwqvUw62xOA7Jxq6
         Mo3cMHRMrgw9rnd251x5xx6gBnUmLtODkcYSyUYZV0XkokBiAOZV0tPdD1XiycamAGLX
         7nyyz9G+fmLZT4BvvIZ3qaVccg5yRvDDocQocDtbPhUwfwBS5705coTiHcjG9EbA4cG1
         YVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LMS6521uwLvF3d0VH9aHVTLaSPCmp9aqfX/Cw2Qkt8=;
        b=hRzED5bP+YMokGQm3lbF9ufWGbIdOxz6fL3cn2BR2pHd9n5o62W27YVJl/Cks09iBy
         mfrn5zvV1cKUoiltRZG2jzg+oXQ4glFHm/CP5vAsTt/5BN95OZDN3zNZdS6ELnCFhKg+
         6L76yt+5SBFrP02RNlgC+zMakGoAo8J6MVlJW+2a3qNsjoFlV8cPY/yylL1P8Vwsrfr6
         UXaBbqWOHt2hwEPLun+Ra69fHZdvZpQ31xgKJUOtC1iysNST8c7XfbeErn18AEDDNvPw
         DBPT4gF7y2tvq1Gxu49O9dw3NXvXoi4CoZZEZ6NdnrtuiDkLMP3C3AoYTyjUYLUoXt/Z
         A0/Q==
X-Gm-Message-State: AOAM530LZboUbvAdv8VD5lW5CqPIBQKrzX37YAp+wOrQPNMKtgED/jz6
        +OIRP4FpsKhlVjzpHmFoSoY=
X-Google-Smtp-Source: ABdhPJyerIt5K+ze4U8Rv+TuJdirbauulSeSldhLjdb6CNMv2sLlQ70UGAhvFiVs4ybWr75JK9jngQ==
X-Received: by 2002:adf:fe4a:: with SMTP id m10mr13371826wrs.332.1622996792572;
        Sun, 06 Jun 2021 09:26:32 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id p12sm13492367wme.43.2021.06.06.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 09:26:32 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1 NeZha board
Date:   Sun, 06 Jun 2021 18:26:30 +0200
Message-ID: <2490489.OUOj5N01qN@jernej-laptop>
In-Reply-To: <1622970249-50770-13-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <1622970249-50770-13-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

I didn't go through all details. After you fix all comments below, you should 
run "make dtbs_check" and fix all reported warnings too.

Dne nedelja, 06. junij 2021 ob 11:04:07 CEST je guoren@kernel.org napisal(a):
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add initial DTS for Allwinner D1 NeZha board having only essential
> devices (uart, dummy, clock, reset, clint, plic, etc).
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-Developed-by: Liu Shaohua <liush@allwinnertech.com>
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> ---
>  arch/riscv/boot/dts/Makefile                       |  1 +
>  arch/riscv/boot/dts/allwinner/Makefile             |  2 +
>  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  | 29 ++++++++
>  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    | 84
> ++++++++++++++++++++++ 4 files changed, 116 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index fe996b8..3e7b264 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -2,5 +2,6 @@
>  subdir-y += sifive
>  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
>  subdir-y += microchip
> +subdir-y += allwinner
> 
>  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/allwinner/Makefile
> b/arch/riscv/boot/dts/allwinner/Makefile new file mode 100644
> index 00000000..4adbf4b
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_SUNXI) += allwinner-d1-nezha-kit.dtb
> diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts new file mode
> 100644
> index 00000000..cd9f7c9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts

Board DT names are comprised of soc name and board name, in this case it would 
be "sun20i-d1-nezha-kit.dts"

> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Usually copyrights are added below spdx id.

> +
> +/dts-v1/;
> +
> +#include "allwinner-d1.dtsi"
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;

This should be part of SoC level DTSI.

> +	model = "Allwinner D1 NeZha Kit";
> +	compatible = "allwinner,d1-nezha-kit";

Board specific compatible string should be followed with SoC compatible, in 
this case "allwinner,sun20i-d1".  You should document it too.

> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";

Above line doesn't belong here. If anything, it should be added dynamically by 
bootloader.

> +		stdout-path = &serial0;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x0 0x20000000>;
> +	};

Ditto for whole memory node.

> +
> +	soc {
> +	};

There is no point having empty nodes.

> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi new file mode 100644
> index 00000000..11cd938
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi

Current naming approach for Allwinner SoC level DTSI is "sun20i-d1.dtsi".

> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)

> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;

Since all peripherals and memory are below 4 GiB, why have 64-bit addresses 
and sizes? It just clutters DT.

> +	model = "Allwinner D1 Soc";
> +	compatible = "allwinner,d1-nezha-kit";

Compatible and model don't belong to SoC level DTSI.

> +
> +	chosen {
> +	};

Remove empty node.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <2400000>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			status = "okay";
> +			compatible = "riscv";
> +			riscv,isa = "rv64imafdcv";
> +			mmu-type = "riscv,sv39";
> +			cpu0_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		reset: reset-sample {
> +			compatible = "thead,reset-sample";
> +			plic-delegate = <0x0 0x101ffffc>;
> +		};
> +
> +		clint: clint@14000000 {
> +			compatible = "riscv,clint0";
> +			interrupts-extended = <
> +				&cpu0_intc  3 &cpu0_intc  7
> +				>;
> +			reg = <0x0 0x14000000 0x0 0x04000000>;
> +			clint,has-no-64bit-mmio;
> +		};
> +
> +		plic: interrupt-controller@10000000 {
> +			#interrupt-cells = <1>;
> +			compatible = "riscv,plic0";
> +			interrupt-controller;
> +			interrupts-extended = <
> +				&cpu0_intc  0xffffffff &cpu0_intc  9
> +				>;
> +			reg = <0x0 0x10000000 0x0 0x04000000>;
> +			reg-names = "control";
> +			riscv,max-priority = <7>;
> +			riscv,ndev = <200>;
> +		};
> +
> +		dummy_apb: apb-clock {
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +			clock-output-names = "dummy_apb";
> +			#clock-cells = <0>;
> +		};
> +
> +		serial0: serial@2500000 {

This should be uart0 and board should have alias for it. Check ARM based 
Allwinner DTs.

Best regards,
Jernej

> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x02500000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <18>;
> +			clocks = <&dummy_apb>;
> +			status = "disabled";
> +		};
> +	};
> +};




