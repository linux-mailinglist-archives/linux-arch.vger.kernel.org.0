Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23B729E34
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbjFIPWc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjFIPWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 11:22:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDAE30F7
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 08:22:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so3238696a12.2
        for <linux-arch@vger.kernel.org>; Fri, 09 Jun 2023 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686324147; x=1688916147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgdpsFvlSHfvL616lpSzlLkpCKPLET85+hweuPq7lJc=;
        b=FzyLHKGcr/Xw1q9ffKxueV/CMkIQ9Sh16XHXg/11EsJ+JRZrZplrMeYCYt/aNFUs3X
         RdPmw7diWOrISV+qzlcK3NoKC95i/SRsMIBtshckxVTJ0Pa4KOVFSkpu/BNhxNnTmGrp
         alRKlSV192nhtWZ4bqi5NyFGNRovkaWhK7ajlUrPgtYKXYULL0QBtwNpGn1BKpoU0q+k
         lfz5KqSMv39OjRz6M8rRoeoEU3DhWBc00/qCbus0vPV02PfoEjgJURxLnUCDqJz5gmNI
         V9HAuk0Zf3E4SV+MY2IKl7tR7OrAqZsFakwO9UUejmT6ygjkv7xuF7XZ1w7vCx2CHA76
         k0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324147; x=1688916147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgdpsFvlSHfvL616lpSzlLkpCKPLET85+hweuPq7lJc=;
        b=ajIJ2pRq5Y5xLdb6wZblLdJfKOwxT8sEmRDpk31wD2FrTuqGWiCZEw+144oFeRjdup
         hovRVsDQeuGEmGtw1hXu9j2Ll78813Z86TERYR6ZeSyvVMPbt1YyrLnionQ0yUZSkgDq
         lwD+01qu//pzscRw6SDo4DS2w2ArrrA7JatCZrXDrgo/MrIpAGxGc9yl1LYEJhiaHJvd
         PPSKQaQeFOaoQsjsoef/rfV7lfXuhWtxBH6ED1GXCQWrAjT30ZD9CB0K1+Q4WvR/qsoK
         IfG0RyN/OWHLWxvVYfa/EIwUjbKoGmwuR+Mw9uuy+5xebJGRvD2xIegO6YSP6bz6/l/Y
         Y5Wg==
X-Gm-Message-State: AC+VfDxVdDz/EGXZChGltWK6yWUtshT9s68zgliKd8AIH3TcpgQ6K1/c
        IYYPUXb7MKT7I1N+eMNAgHNd+A==
X-Google-Smtp-Source: ACHHUZ7q69XNyD0Ob8QMei1RaexdonLE4GtsIMKFsMTA3rAxns1PVZy9ZARL+DMqns9sNRl+z541mA==
X-Received: by 2002:a17:907:25cc:b0:94f:6218:191d with SMTP id ae12-20020a17090725cc00b0094f6218191dmr2079991ejc.32.1686324146722;
        Fri, 09 Jun 2023 08:22:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906565300b00969e9fef151sm1421651ejr.97.2023.06.09.08.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:22:26 -0700 (PDT)
Message-ID: <2fe0c7f9-55fc-ae63-3631-8526a0212ccd@linaro.org>
Date:   Fri, 9 Jun 2023 17:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/9] virt: geniezone: Add GenieZone hypervisor support
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
References: <20230609085214.31071-1-yi-de.wu@mediatek.com>
 <20230609085214.31071-3-yi-de.wu@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609085214.31071-3-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 09/06/2023 10:52, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone is MediaTek hypervisor solution, and it is running in EL2
> stand alone as a type-I hypervisor. This patch exports a set of ioctl
> interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
> lifecycle (creation and destroy) on GenieZone.

...

> +static int gzvm_drv_probe(void)
> +{
> +	int ret;
> +
> +	if (gzvm_arch_probe() != 0) {
> +		pr_err("Not found available conduit\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = misc_register(&gzvm_dev);
> +	if (ret)
> +		return ret;
> +	gzvm_debug_dev = &gzvm_dev;
> +
> +	return 0;
> +}
> +
> +static int gzvm_drv_remove(void)
> +{
> +	destroy_all_vm();
> +	misc_deregister(&gzvm_dev);
> +	return 0;
> +}
> +
> +static int gzvm_dev_init(void)
> +{
> +	return gzvm_drv_probe();

So for every system and architecture you want to: probe, run some SMC
and then print error that it is not othe system you wanted.

I don't think this is what we want. You basically pollute all of other
users just to have your hypervisor guest additions...


Best regards,
Krzysztof

