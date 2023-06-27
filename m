Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B673F8C3
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjF0JaQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 05:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjF0JaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 05:30:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FC1987;
        Tue, 27 Jun 2023 02:30:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B6C65C01D5;
        Tue, 27 Jun 2023 05:30:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 27 Jun 2023 05:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687858214; x=1687944614; bh=d/
        8PAsCjbmMqsAZVfulXX8NLMmKaUcPEmXDNbRBP/iY=; b=r1/VlKLwjWRKxQKnr7
        EeN5vuWsH4K5/M6jVqZVzAX8NjH3CgUzYePswdMd4UHACyZ6z8wdcg3YNz4Ffh5D
        0T3XhcLN7bzWS8GtCL2kTxtY7s1YooHQ6ecW7RflD0T1TxJ1gi44wpVlRmI59dM7
        2+/OSFs0BJ+RNkf+nbQ/Qa7WsYSCopCzYKPN2fnBbcCZO5kzmWt6EqBSrdYyl9LT
        IDwSkH5LpjAzAzIj9KbMye2XTf/J9cKSz362tawBRK3z3kRZXFzTBXuxPBXKjPT5
        UFxnpAJ4wttOZ90/adZrMDwV5d3z/C4IHHpq/URcUthI7ADS93ElS1UPXmV7Jirq
        Fb5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687858214; x=1687944614; bh=d/8PAsCjbmMqs
        AZVfulXX8NLMmKaUcPEmXDNbRBP/iY=; b=rCwudNcaAgAQJUVmw90VYxVfNvqm7
        fy9DLhi/W77KBRwMHSFoxQXqU5fshBRCW3xOsT4GMGeWdb99ohRMzLpPyDhEQ06S
        GFZZOrcdu0lJz3PFTKbqMkuYwyiYPso5m7o0Ja+66aNM+r9TAk3wHvgPNq/a8gR2
        xd0t4kkOqPvXTlubXsYycTioiz50fnlqftXe6owfCdnWyTZYOgq5Ye2RnwoG/9JF
        tW9ASyerDLMkCZ8hShqfgWoqbPs7VzvEyK4sio5jPFHWnBFMpCXttyQnHaDFC76H
        mOnmYK6q43iVruVYfva6NXn1XGnnUveYyYewtcVCNQsaXun9FJsaN/Alg==
X-ME-Sender: <xms:JayaZBitbYQs-Nbz28YFL0hH-f0e91zEr79uEZ1IirHIFTpGCjBsPA>
    <xme:JayaZGBfTJaZktWQBIp1RUSjIN5yKIGrJm4THO0JeCCOpqZRSPrFGn8hfnT8TUcct
    FDjcdDzbHv8a2_4hIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JayaZBE0FcAdCnr77YYyC4hha2Hm-2JikOM2MHIazIgLtw6DXchElg>
    <xmx:JayaZGTdXdg0D5cq1tbQYM304eIeHx8lNL_d9G-BpuLbYqjr7gOAsw>
    <xmx:JayaZOzfUoFjL_pt_6oCsyRCWL5__Cj3BSwdnysopAOk-ai5cDh0OA>
    <xmx:JqyaZLhyZFgVQY0ouFIpf6Ake8BSf-89DyB_m7aWKn-7mfbBV0Rbiw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CBBCB60083; Tue, 27 Jun 2023 05:30:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8c50cf74-fd21-4b86-8ac8-1445ff242d48@app.fastmail.com>
In-Reply-To: <20230609085214.31071-6-yi-de.wu@mediatek.com>
References: <20230609085214.31071-1-yi-de.wu@mediatek.com>
 <20230609085214.31071-6-yi-de.wu@mediatek.com>
Date:   Tue, 27 Jun 2023 11:29:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Yi-De_Wu_=28=E5=90=B3=E4=B8=80=E5=BE=B7=29?= 
        <yi-de.wu@mediatek.com>,
        =?UTF-8?Q?Yingshiuan_Pan_=28=E6=BD=98=E7=A9=8E=E8=BB=92=29?= 
        <yingshiuan.pan@mediatek.com>,
        =?UTF-8?Q?Ze-yu_Wang_=28=E7=8E=8B=E6=BE=A4=E5=AE=87=29?= 
        <ze-yu.wang@mediatek.com>, "Jonathan Corbet" <corbet@lwn.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        =?UTF-8?Q?Jades_Shih_=28=E6=96=BD=E5=90=91=E7=8E=A8=29?= 
        <jades.shih@mediatek.com>, "Miles Chen" <miles.chen@mediatek.com>,
        =?UTF-8?Q?Ivan_Tseng_=28=E6=9B=BE=E5=BF=97=E8=BB=92=29?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?Q?MY_Chuang_=28=E8=8E=8A=E6=98=8E=E8=BA=8D=29?= 
        <my.chuang@mediatek.com>,
        =?UTF-8?Q?Shawn_Hsiao_=28=E8=95=AD=E5=BF=97=E7=A5=A5=29?= 
        <shawn.hsiao@mediatek.com>,
        =?UTF-8?Q?PeiLun_Suei_=28=E9=9A=8B=E5=9F=B9=E5=80=AB=29?= 
        <peilun.suei@mediatek.com>,
        =?UTF-8?Q?Liju-clr_Chen_=28=E9=99=B3=E9=BA=97=E5=A6=82=29?= 
        <liju-clr.chen@mediatek.com>,
        =?UTF-8?Q?Chi-shen_Yeh_=28=E8=91=89=E5=A5=87=E8=BB=92=29?= 
        <chi-shen.yeh@mediatek.com>
Subject: Re: [PATCH v4 5/9] virt: geniezone: Add irqfd support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 9, 2023, at 10:52, Yi-De Wu wrote:
> 
>  /**
>   * gzvm_hypercall_wrapper()
> @@ -72,6 +73,11 @@ static inline gzvm_vcpu_id_t 
> get_vcpuid_from_tuple(unsigned int tuple)
>  	return (gzvm_vcpu_id_t)(tuple & 0xffff);
>  }
> 
> +struct gzvm_vcpu_hwstate {
> +	__u32 nr_lrs;
> +	__u64 lr[GIC_V3_NR_LRS];
> +};

This is not a good definition for a hardware data structure, as there
is architecture specific implicit padding between the two members.

Better add an explicit '__u32 __pad;' in the middle to make it clear
what the actual layout is and make it portable.

If this is an interface to the hypervisor, it should probably also
use explicit endianess, using __le32 and __le64 instead of __u32
and __u64, along with the corresponding accessors.

      Arnd
