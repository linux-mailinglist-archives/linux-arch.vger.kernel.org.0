Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6794E70DBA8
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEWLob (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 07:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjEWLob (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 07:44:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42EEAFE;
        Tue, 23 May 2023 04:44:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A683139F;
        Tue, 23 May 2023 04:45:15 -0700 (PDT)
Received: from [10.57.84.70] (unknown [10.57.84.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7B6C3F6C4;
        Tue, 23 May 2023 04:44:27 -0700 (PDT)
Message-ID: <1ab0a4e0-1eb9-fc78-2df2-ad0f3802d06a@arm.com>
Date:   Tue, 23 May 2023 12:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] arm: docs: Move Arm documentation to
 Documentation/arch/
Content-Language: en-GB
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-2-corbet@lwn.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230519164607.38845-2-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-05-19 17:46, Jonathan Corbet wrote:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/arch into arch/ and fix all documentation references.

Nit: I guess the "and fix all documentation references" part ended up 
being split out into the subsequent patches?

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
[...]
>   Documentation/translations/zh_CN/arm/Booting                  | 4 ++--
>   Documentation/translations/zh_CN/arm/kernel_user_helpers.txt  | 4 ++--

...so I imagine these two rogue hunks probably want to be in patch #2 now.

Thanks,
Robin.
