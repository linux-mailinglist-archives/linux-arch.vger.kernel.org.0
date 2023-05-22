Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF170B6FE
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjEVHt6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjEVHtf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 03:49:35 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EE41987;
        Mon, 22 May 2023 00:48:05 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2BHCk006853;
        Mon, 22 May 2023 09:46:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=L8v0c2QoqVhoM2JYbH7IDFVu36IWw5DD++7lsbQQiHU=;
 b=DtClVabR3uWt3bAX4XfVy90kWm49HOO7QlQWVY69JluD+VnHm2bGoBV4rVVIHsHeHaXb
 aON1x6lJJQF4KOJXDPaT5NAxEgT/jN4VwOf15+ZMMDoLPE7CHbP4XbSXHugQSSSXp1Bp
 Ov8ko/jCvx67iK8g9PiGO1ff0m3QzKCEIbE/GhEOZC1PfDn7MxZGGrfQwoa2w/vW7YoH
 8BrJvRz0VsmEo3+8SStARLoqVgUUiNStjktABosE0fFg8GRZOsMYCh+aYarmbdGqqH9C
 WHMqmAmwa49bim9kY/bnUpbq7dwTbt8CcmkA6GUhz2Ywry8Xo82pZnKSsMu8PEMKUTBl cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qpn3g9983-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:46:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C80810002A;
        Mon, 22 May 2023 09:46:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0ACD021860F;
        Mon, 22 May 2023 09:46:17 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 22 May
 2023 09:46:16 +0200
Message-ID: <f737ef0a-4574-ad2b-ca99-5950d777a3e4@foss.st.com>
Date:   Mon, 22 May 2023 09:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] arm: docs: Move Arm documentation to
 Documentation/arch/
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-2-corbet@lwn.net>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230519164607.38845-2-corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/19/23 18:46, Jonathan Corbet wrote:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/arch into arch/ and fix all documentation references.
> 
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---

Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>


>   Documentation/{ => arch}/arm/arm.rst                          | 0
>   Documentation/{ => arch}/arm/booting.rst                      | 0
>   Documentation/{ => arch}/arm/cluster-pm-race-avoidance.rst    | 0
>   Documentation/{ => arch}/arm/features.rst                     | 0
>   Documentation/{ => arch}/arm/firmware.rst                     | 0
>   Documentation/{ => arch}/arm/google/chromebook-boot-flow.rst  | 0
>   Documentation/{ => arch}/arm/index.rst                        | 0
>   Documentation/{ => arch}/arm/interrupts.rst                   | 0
>   Documentation/{ => arch}/arm/ixp4xx.rst                       | 0
>   Documentation/{ => arch}/arm/kernel_mode_neon.rst             | 0
>   Documentation/{ => arch}/arm/kernel_user_helpers.rst          | 0
>   Documentation/{ => arch}/arm/keystone/knav-qmss.rst           | 0
>   Documentation/{ => arch}/arm/keystone/overview.rst            | 0
>   Documentation/{ => arch}/arm/marvell.rst                      | 0
>   Documentation/{ => arch}/arm/mem_alignment.rst                | 0
>   Documentation/{ => arch}/arm/memory.rst                       | 0
>   Documentation/{ => arch}/arm/microchip.rst                    | 0
>   Documentation/{ => arch}/arm/netwinder.rst                    | 0
>   Documentation/{ => arch}/arm/nwfpe/index.rst                  | 0
>   Documentation/{ => arch}/arm/nwfpe/netwinder-fpe.rst          | 0
>   Documentation/{ => arch}/arm/nwfpe/notes.rst                  | 0
>   Documentation/{ => arch}/arm/nwfpe/nwfpe.rst                  | 0
>   Documentation/{ => arch}/arm/nwfpe/todo.rst                   | 0
>   Documentation/{ => arch}/arm/omap/dss.rst                     | 0
>   Documentation/{ => arch}/arm/omap/index.rst                   | 0
>   Documentation/{ => arch}/arm/omap/omap.rst                    | 0
>   Documentation/{ => arch}/arm/omap/omap_pm.rst                 | 0
>   Documentation/{ => arch}/arm/porting.rst                      | 0
>   Documentation/{ => arch}/arm/pxa/mfp.rst                      | 0
>   Documentation/{ => arch}/arm/sa1100/assabet.rst               | 0
>   Documentation/{ => arch}/arm/sa1100/cerf.rst                  | 0
>   Documentation/{ => arch}/arm/sa1100/index.rst                 | 0
>   Documentation/{ => arch}/arm/sa1100/lart.rst                  | 0
>   Documentation/{ => arch}/arm/sa1100/serial_uart.rst           | 0
>   Documentation/{ => arch}/arm/samsung/bootloader-interface.rst | 0
>   .../{ => arch}/arm/samsung/clksrc-change-registers.awk        | 0
>   Documentation/{ => arch}/arm/samsung/gpio.rst                 | 0
>   Documentation/{ => arch}/arm/samsung/index.rst                | 0
>   Documentation/{ => arch}/arm/samsung/overview.rst             | 0
>   Documentation/{ => arch}/arm/setup.rst                        | 0
>   Documentation/{ => arch}/arm/spear/overview.rst               | 0
>   Documentation/{ => arch}/arm/sti/overview.rst                 | 0
>   Documentation/{ => arch}/arm/sti/stih407-overview.rst         | 0
>   Documentation/{ => arch}/arm/sti/stih418-overview.rst         | 0
>   Documentation/{ => arch}/arm/stm32/overview.rst               | 0
>   .../{ => arch}/arm/stm32/stm32-dma-mdma-chaining.rst          | 0
>   Documentation/{ => arch}/arm/stm32/stm32f429-overview.rst     | 0
>   Documentation/{ => arch}/arm/stm32/stm32f746-overview.rst     | 0
>   Documentation/{ => arch}/arm/stm32/stm32f769-overview.rst     | 0
>   Documentation/{ => arch}/arm/stm32/stm32h743-overview.rst     | 0
>   Documentation/{ => arch}/arm/stm32/stm32h750-overview.rst     | 0
>   Documentation/{ => arch}/arm/stm32/stm32mp13-overview.rst     | 0
>   Documentation/{ => arch}/arm/stm32/stm32mp151-overview.rst    | 0
>   Documentation/{ => arch}/arm/stm32/stm32mp157-overview.rst    | 0
>   Documentation/{ => arch}/arm/sunxi.rst                        | 0
>   Documentation/{ => arch}/arm/sunxi/clocks.rst                 | 0
>   Documentation/{ => arch}/arm/swp_emulation.rst                | 0
>   Documentation/{ => arch}/arm/tcm.rst                          | 0
>   Documentation/{ => arch}/arm/uefi.rst                         | 0
>   Documentation/{ => arch}/arm/vfp/release-notes.rst            | 0
>   Documentation/{ => arch}/arm/vlocks.rst                       | 0
>   Documentation/arch/index.rst                                  | 2 +-
>   Documentation/translations/zh_CN/arm/Booting                  | 4 ++--
>   Documentation/translations/zh_CN/arm/kernel_user_helpers.txt  | 4 ++--
>   64 files changed, 5 insertions(+), 5 deletions(-)
>   rename Documentation/{ => arch}/arm/arm.rst (100%)
>   rename Documentation/{ => arch}/arm/booting.rst (100%)
>   rename Documentation/{ => arch}/arm/cluster-pm-race-avoidance.rst (100%)
>   rename Documentation/{ => arch}/arm/features.rst (100%)
>   rename Documentation/{ => arch}/arm/firmware.rst (100%)
>   rename Documentation/{ => arch}/arm/google/chromebook-boot-flow.rst (100%)
>   rename Documentation/{ => arch}/arm/index.rst (100%)
>   rename Documentation/{ => arch}/arm/interrupts.rst (100%)
>   rename Documentation/{ => arch}/arm/ixp4xx.rst (100%)
>   rename Documentation/{ => arch}/arm/kernel_mode_neon.rst (100%)
>   rename Documentation/{ => arch}/arm/kernel_user_helpers.rst (100%)
>   rename Documentation/{ => arch}/arm/keystone/knav-qmss.rst (100%)
>   rename Documentation/{ => arch}/arm/keystone/overview.rst (100%)
>   rename Documentation/{ => arch}/arm/marvell.rst (100%)
>   rename Documentation/{ => arch}/arm/mem_alignment.rst (100%)
>   rename Documentation/{ => arch}/arm/memory.rst (100%)
>   rename Documentation/{ => arch}/arm/microchip.rst (100%)
>   rename Documentation/{ => arch}/arm/netwinder.rst (100%)
>   rename Documentation/{ => arch}/arm/nwfpe/index.rst (100%)
>   rename Documentation/{ => arch}/arm/nwfpe/netwinder-fpe.rst (100%)
>   rename Documentation/{ => arch}/arm/nwfpe/notes.rst (100%)
>   rename Documentation/{ => arch}/arm/nwfpe/nwfpe.rst (100%)
>   rename Documentation/{ => arch}/arm/nwfpe/todo.rst (100%)
>   rename Documentation/{ => arch}/arm/omap/dss.rst (100%)
>   rename Documentation/{ => arch}/arm/omap/index.rst (100%)
>   rename Documentation/{ => arch}/arm/omap/omap.rst (100%)
>   rename Documentation/{ => arch}/arm/omap/omap_pm.rst (100%)
>   rename Documentation/{ => arch}/arm/porting.rst (100%)
>   rename Documentation/{ => arch}/arm/pxa/mfp.rst (100%)
>   rename Documentation/{ => arch}/arm/sa1100/assabet.rst (100%)
>   rename Documentation/{ => arch}/arm/sa1100/cerf.rst (100%)
>   rename Documentation/{ => arch}/arm/sa1100/index.rst (100%)
>   rename Documentation/{ => arch}/arm/sa1100/lart.rst (100%)
>   rename Documentation/{ => arch}/arm/sa1100/serial_uart.rst (100%)
>   rename Documentation/{ => arch}/arm/samsung/bootloader-interface.rst (100%)
>   rename Documentation/{ => arch}/arm/samsung/clksrc-change-registers.awk (100%)
>   rename Documentation/{ => arch}/arm/samsung/gpio.rst (100%)
>   rename Documentation/{ => arch}/arm/samsung/index.rst (100%)
>   rename Documentation/{ => arch}/arm/samsung/overview.rst (100%)
>   rename Documentation/{ => arch}/arm/setup.rst (100%)
>   rename Documentation/{ => arch}/arm/spear/overview.rst (100%)
>   rename Documentation/{ => arch}/arm/sti/overview.rst (100%)
>   rename Documentation/{ => arch}/arm/sti/stih407-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/sti/stih418-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32-dma-mdma-chaining.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32f429-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32f746-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32f769-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32h743-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32h750-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32mp13-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32mp151-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/stm32/stm32mp157-overview.rst (100%)
>   rename Documentation/{ => arch}/arm/sunxi.rst (100%)
>   rename Documentation/{ => arch}/arm/sunxi/clocks.rst (100%)
>   rename Documentation/{ => arch}/arm/swp_emulation.rst (100%)
>   rename Documentation/{ => arch}/arm/tcm.rst (100%)
>   rename Documentation/{ => arch}/arm/uefi.rst (100%)
>   rename Documentation/{ => arch}/arm/vfp/release-notes.rst (100%)
>   rename Documentation/{ => arch}/arm/vlocks.rst (100%)
> 
> diff --git a/Documentation/arm/arm.rst b/Documentation/arch/arm/arm.rst
> similarity index 100%
> rename from Documentation/arm/arm.rst
> rename to Documentation/arch/arm/arm.rst
> diff --git a/Documentation/arm/booting.rst b/Documentation/arch/arm/booting.rst
> similarity index 100%
> rename from Documentation/arm/booting.rst
> rename to Documentation/arch/arm/booting.rst
> diff --git a/Documentation/arm/cluster-pm-race-avoidance.rst b/Documentation/arch/arm/cluster-pm-race-avoidance.rst
> similarity index 100%
> rename from Documentation/arm/cluster-pm-race-avoidance.rst
> rename to Documentation/arch/arm/cluster-pm-race-avoidance.rst
> diff --git a/Documentation/arm/features.rst b/Documentation/arch/arm/features.rst
> similarity index 100%
> rename from Documentation/arm/features.rst
> rename to Documentation/arch/arm/features.rst
> diff --git a/Documentation/arm/firmware.rst b/Documentation/arch/arm/firmware.rst
> similarity index 100%
> rename from Documentation/arm/firmware.rst
> rename to Documentation/arch/arm/firmware.rst
> diff --git a/Documentation/arm/google/chromebook-boot-flow.rst b/Documentation/arch/arm/google/chromebook-boot-flow.rst
> similarity index 100%
> rename from Documentation/arm/google/chromebook-boot-flow.rst
> rename to Documentation/arch/arm/google/chromebook-boot-flow.rst
> diff --git a/Documentation/arm/index.rst b/Documentation/arch/arm/index.rst
> similarity index 100%
> rename from Documentation/arm/index.rst
> rename to Documentation/arch/arm/index.rst
> diff --git a/Documentation/arm/interrupts.rst b/Documentation/arch/arm/interrupts.rst
> similarity index 100%
> rename from Documentation/arm/interrupts.rst
> rename to Documentation/arch/arm/interrupts.rst
> diff --git a/Documentation/arm/ixp4xx.rst b/Documentation/arch/arm/ixp4xx.rst
> similarity index 100%
> rename from Documentation/arm/ixp4xx.rst
> rename to Documentation/arch/arm/ixp4xx.rst
> diff --git a/Documentation/arm/kernel_mode_neon.rst b/Documentation/arch/arm/kernel_mode_neon.rst
> similarity index 100%
> rename from Documentation/arm/kernel_mode_neon.rst
> rename to Documentation/arch/arm/kernel_mode_neon.rst
> diff --git a/Documentation/arm/kernel_user_helpers.rst b/Documentation/arch/arm/kernel_user_helpers.rst
> similarity index 100%
> rename from Documentation/arm/kernel_user_helpers.rst
> rename to Documentation/arch/arm/kernel_user_helpers.rst
> diff --git a/Documentation/arm/keystone/knav-qmss.rst b/Documentation/arch/arm/keystone/knav-qmss.rst
> similarity index 100%
> rename from Documentation/arm/keystone/knav-qmss.rst
> rename to Documentation/arch/arm/keystone/knav-qmss.rst
> diff --git a/Documentation/arm/keystone/overview.rst b/Documentation/arch/arm/keystone/overview.rst
> similarity index 100%
> rename from Documentation/arm/keystone/overview.rst
> rename to Documentation/arch/arm/keystone/overview.rst
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arch/arm/marvell.rst
> similarity index 100%
> rename from Documentation/arm/marvell.rst
> rename to Documentation/arch/arm/marvell.rst
> diff --git a/Documentation/arm/mem_alignment.rst b/Documentation/arch/arm/mem_alignment.rst
> similarity index 100%
> rename from Documentation/arm/mem_alignment.rst
> rename to Documentation/arch/arm/mem_alignment.rst
> diff --git a/Documentation/arm/memory.rst b/Documentation/arch/arm/memory.rst
> similarity index 100%
> rename from Documentation/arm/memory.rst
> rename to Documentation/arch/arm/memory.rst
> diff --git a/Documentation/arm/microchip.rst b/Documentation/arch/arm/microchip.rst
> similarity index 100%
> rename from Documentation/arm/microchip.rst
> rename to Documentation/arch/arm/microchip.rst
> diff --git a/Documentation/arm/netwinder.rst b/Documentation/arch/arm/netwinder.rst
> similarity index 100%
> rename from Documentation/arm/netwinder.rst
> rename to Documentation/arch/arm/netwinder.rst
> diff --git a/Documentation/arm/nwfpe/index.rst b/Documentation/arch/arm/nwfpe/index.rst
> similarity index 100%
> rename from Documentation/arm/nwfpe/index.rst
> rename to Documentation/arch/arm/nwfpe/index.rst
> diff --git a/Documentation/arm/nwfpe/netwinder-fpe.rst b/Documentation/arch/arm/nwfpe/netwinder-fpe.rst
> similarity index 100%
> rename from Documentation/arm/nwfpe/netwinder-fpe.rst
> rename to Documentation/arch/arm/nwfpe/netwinder-fpe.rst
> diff --git a/Documentation/arm/nwfpe/notes.rst b/Documentation/arch/arm/nwfpe/notes.rst
> similarity index 100%
> rename from Documentation/arm/nwfpe/notes.rst
> rename to Documentation/arch/arm/nwfpe/notes.rst
> diff --git a/Documentation/arm/nwfpe/nwfpe.rst b/Documentation/arch/arm/nwfpe/nwfpe.rst
> similarity index 100%
> rename from Documentation/arm/nwfpe/nwfpe.rst
> rename to Documentation/arch/arm/nwfpe/nwfpe.rst
> diff --git a/Documentation/arm/nwfpe/todo.rst b/Documentation/arch/arm/nwfpe/todo.rst
> similarity index 100%
> rename from Documentation/arm/nwfpe/todo.rst
> rename to Documentation/arch/arm/nwfpe/todo.rst
> diff --git a/Documentation/arm/omap/dss.rst b/Documentation/arch/arm/omap/dss.rst
> similarity index 100%
> rename from Documentation/arm/omap/dss.rst
> rename to Documentation/arch/arm/omap/dss.rst
> diff --git a/Documentation/arm/omap/index.rst b/Documentation/arch/arm/omap/index.rst
> similarity index 100%
> rename from Documentation/arm/omap/index.rst
> rename to Documentation/arch/arm/omap/index.rst
> diff --git a/Documentation/arm/omap/omap.rst b/Documentation/arch/arm/omap/omap.rst
> similarity index 100%
> rename from Documentation/arm/omap/omap.rst
> rename to Documentation/arch/arm/omap/omap.rst
> diff --git a/Documentation/arm/omap/omap_pm.rst b/Documentation/arch/arm/omap/omap_pm.rst
> similarity index 100%
> rename from Documentation/arm/omap/omap_pm.rst
> rename to Documentation/arch/arm/omap/omap_pm.rst
> diff --git a/Documentation/arm/porting.rst b/Documentation/arch/arm/porting.rst
> similarity index 100%
> rename from Documentation/arm/porting.rst
> rename to Documentation/arch/arm/porting.rst
> diff --git a/Documentation/arm/pxa/mfp.rst b/Documentation/arch/arm/pxa/mfp.rst
> similarity index 100%
> rename from Documentation/arm/pxa/mfp.rst
> rename to Documentation/arch/arm/pxa/mfp.rst
> diff --git a/Documentation/arm/sa1100/assabet.rst b/Documentation/arch/arm/sa1100/assabet.rst
> similarity index 100%
> rename from Documentation/arm/sa1100/assabet.rst
> rename to Documentation/arch/arm/sa1100/assabet.rst
> diff --git a/Documentation/arm/sa1100/cerf.rst b/Documentation/arch/arm/sa1100/cerf.rst
> similarity index 100%
> rename from Documentation/arm/sa1100/cerf.rst
> rename to Documentation/arch/arm/sa1100/cerf.rst
> diff --git a/Documentation/arm/sa1100/index.rst b/Documentation/arch/arm/sa1100/index.rst
> similarity index 100%
> rename from Documentation/arm/sa1100/index.rst
> rename to Documentation/arch/arm/sa1100/index.rst
> diff --git a/Documentation/arm/sa1100/lart.rst b/Documentation/arch/arm/sa1100/lart.rst
> similarity index 100%
> rename from Documentation/arm/sa1100/lart.rst
> rename to Documentation/arch/arm/sa1100/lart.rst
> diff --git a/Documentation/arm/sa1100/serial_uart.rst b/Documentation/arch/arm/sa1100/serial_uart.rst
> similarity index 100%
> rename from Documentation/arm/sa1100/serial_uart.rst
> rename to Documentation/arch/arm/sa1100/serial_uart.rst
> diff --git a/Documentation/arm/samsung/bootloader-interface.rst b/Documentation/arch/arm/samsung/bootloader-interface.rst
> similarity index 100%
> rename from Documentation/arm/samsung/bootloader-interface.rst
> rename to Documentation/arch/arm/samsung/bootloader-interface.rst
> diff --git a/Documentation/arm/samsung/clksrc-change-registers.awk b/Documentation/arch/arm/samsung/clksrc-change-registers.awk
> similarity index 100%
> rename from Documentation/arm/samsung/clksrc-change-registers.awk
> rename to Documentation/arch/arm/samsung/clksrc-change-registers.awk
> diff --git a/Documentation/arm/samsung/gpio.rst b/Documentation/arch/arm/samsung/gpio.rst
> similarity index 100%
> rename from Documentation/arm/samsung/gpio.rst
> rename to Documentation/arch/arm/samsung/gpio.rst
> diff --git a/Documentation/arm/samsung/index.rst b/Documentation/arch/arm/samsung/index.rst
> similarity index 100%
> rename from Documentation/arm/samsung/index.rst
> rename to Documentation/arch/arm/samsung/index.rst
> diff --git a/Documentation/arm/samsung/overview.rst b/Documentation/arch/arm/samsung/overview.rst
> similarity index 100%
> rename from Documentation/arm/samsung/overview.rst
> rename to Documentation/arch/arm/samsung/overview.rst
> diff --git a/Documentation/arm/setup.rst b/Documentation/arch/arm/setup.rst
> similarity index 100%
> rename from Documentation/arm/setup.rst
> rename to Documentation/arch/arm/setup.rst
> diff --git a/Documentation/arm/spear/overview.rst b/Documentation/arch/arm/spear/overview.rst
> similarity index 100%
> rename from Documentation/arm/spear/overview.rst
> rename to Documentation/arch/arm/spear/overview.rst
> diff --git a/Documentation/arm/sti/overview.rst b/Documentation/arch/arm/sti/overview.rst
> similarity index 100%
> rename from Documentation/arm/sti/overview.rst
> rename to Documentation/arch/arm/sti/overview.rst
> diff --git a/Documentation/arm/sti/stih407-overview.rst b/Documentation/arch/arm/sti/stih407-overview.rst
> similarity index 100%
> rename from Documentation/arm/sti/stih407-overview.rst
> rename to Documentation/arch/arm/sti/stih407-overview.rst
> diff --git a/Documentation/arm/sti/stih418-overview.rst b/Documentation/arch/arm/sti/stih418-overview.rst
> similarity index 100%
> rename from Documentation/arm/sti/stih418-overview.rst
> rename to Documentation/arch/arm/sti/stih418-overview.rst
> diff --git a/Documentation/arm/stm32/overview.rst b/Documentation/arch/arm/stm32/overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/overview.rst
> rename to Documentation/arch/arm/stm32/overview.rst
> diff --git a/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst b/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
> rename to Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
> diff --git a/Documentation/arm/stm32/stm32f429-overview.rst b/Documentation/arch/arm/stm32/stm32f429-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32f429-overview.rst
> rename to Documentation/arch/arm/stm32/stm32f429-overview.rst
> diff --git a/Documentation/arm/stm32/stm32f746-overview.rst b/Documentation/arch/arm/stm32/stm32f746-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32f746-overview.rst
> rename to Documentation/arch/arm/stm32/stm32f746-overview.rst
> diff --git a/Documentation/arm/stm32/stm32f769-overview.rst b/Documentation/arch/arm/stm32/stm32f769-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32f769-overview.rst
> rename to Documentation/arch/arm/stm32/stm32f769-overview.rst
> diff --git a/Documentation/arm/stm32/stm32h743-overview.rst b/Documentation/arch/arm/stm32/stm32h743-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32h743-overview.rst
> rename to Documentation/arch/arm/stm32/stm32h743-overview.rst
> diff --git a/Documentation/arm/stm32/stm32h750-overview.rst b/Documentation/arch/arm/stm32/stm32h750-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32h750-overview.rst
> rename to Documentation/arch/arm/stm32/stm32h750-overview.rst
> diff --git a/Documentation/arm/stm32/stm32mp13-overview.rst b/Documentation/arch/arm/stm32/stm32mp13-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32mp13-overview.rst
> rename to Documentation/arch/arm/stm32/stm32mp13-overview.rst
> diff --git a/Documentation/arm/stm32/stm32mp151-overview.rst b/Documentation/arch/arm/stm32/stm32mp151-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32mp151-overview.rst
> rename to Documentation/arch/arm/stm32/stm32mp151-overview.rst
> diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arch/arm/stm32/stm32mp157-overview.rst
> similarity index 100%
> rename from Documentation/arm/stm32/stm32mp157-overview.rst
> rename to Documentation/arch/arm/stm32/stm32mp157-overview.rst
> diff --git a/Documentation/arm/sunxi.rst b/Documentation/arch/arm/sunxi.rst
> similarity index 100%
> rename from Documentation/arm/sunxi.rst
> rename to Documentation/arch/arm/sunxi.rst
> diff --git a/Documentation/arm/sunxi/clocks.rst b/Documentation/arch/arm/sunxi/clocks.rst
> similarity index 100%
> rename from Documentation/arm/sunxi/clocks.rst
> rename to Documentation/arch/arm/sunxi/clocks.rst
> diff --git a/Documentation/arm/swp_emulation.rst b/Documentation/arch/arm/swp_emulation.rst
> similarity index 100%
> rename from Documentation/arm/swp_emulation.rst
> rename to Documentation/arch/arm/swp_emulation.rst
> diff --git a/Documentation/arm/tcm.rst b/Documentation/arch/arm/tcm.rst
> similarity index 100%
> rename from Documentation/arm/tcm.rst
> rename to Documentation/arch/arm/tcm.rst
> diff --git a/Documentation/arm/uefi.rst b/Documentation/arch/arm/uefi.rst
> similarity index 100%
> rename from Documentation/arm/uefi.rst
> rename to Documentation/arch/arm/uefi.rst
> diff --git a/Documentation/arm/vfp/release-notes.rst b/Documentation/arch/arm/vfp/release-notes.rst
> similarity index 100%
> rename from Documentation/arm/vfp/release-notes.rst
> rename to Documentation/arch/arm/vfp/release-notes.rst
> diff --git a/Documentation/arm/vlocks.rst b/Documentation/arch/arm/vlocks.rst
> similarity index 100%
> rename from Documentation/arm/vlocks.rst
> rename to Documentation/arch/arm/vlocks.rst
> diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
> index 80ee31016584..21e3d0b61004 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -10,7 +10,7 @@ implementation.
>      :maxdepth: 2
>   
>      arc/index
> -   ../arm/index
> +   arm/index
>      ../arm64/index
>      ia64/index
>      ../loongarch/index
> diff --git a/Documentation/translations/zh_CN/arm/Booting b/Documentation/translations/zh_CN/arm/Booting
> index 5ecea0767893..f18585156b67 100644
> --- a/Documentation/translations/zh_CN/arm/Booting
> +++ b/Documentation/translations/zh_CN/arm/Booting
> @@ -1,4 +1,4 @@
> -Chinese translated version of Documentation/arm/booting.rst
> +Chinese translated version of Documentation/arch/arm/booting.rst
>   
>   If you have any comment or update to the content, please contact the
>   original document maintainer directly.  However, if you have a problem
> @@ -9,7 +9,7 @@ or if there is a problem with the translation.
>   Maintainer: Russell King <linux@arm.linux.org.uk>
>   Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
>   ---------------------------------------------------------------------
> -Documentation/arm/booting.rst 的中文翻译
> +Documentation/arch/arm/booting.rst 的中文翻译
>   
>   如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
>   交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
> diff --git a/Documentation/translations/zh_CN/arm/kernel_user_helpers.txt b/Documentation/translations/zh_CN/arm/kernel_user_helpers.txt
> index 99af4363984d..018eb7d54233 100644
> --- a/Documentation/translations/zh_CN/arm/kernel_user_helpers.txt
> +++ b/Documentation/translations/zh_CN/arm/kernel_user_helpers.txt
> @@ -1,4 +1,4 @@
> -Chinese translated version of Documentation/arm/kernel_user_helpers.rst
> +Chinese translated version of Documentation/arch/arm/kernel_user_helpers.rst
>   
>   If you have any comment or update to the content, please contact the
>   original document maintainer directly.  However, if you have a problem
> @@ -10,7 +10,7 @@ Maintainer: Nicolas Pitre <nicolas.pitre@linaro.org>
>   		Dave Martin <dave.martin@linaro.org>
>   Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
>   ---------------------------------------------------------------------
> -Documentation/arm/kernel_user_helpers.rst 的中文翻译
> +Documentation/arch/arm/kernel_user_helpers.rst 的中文翻译
>   
>   如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
>   交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻

