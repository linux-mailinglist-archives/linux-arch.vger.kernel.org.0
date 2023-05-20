Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3170A8B5
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 17:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjETPOJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 May 2023 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETPOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 May 2023 11:14:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48E115;
        Sat, 20 May 2023 08:14:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 007223200943;
        Sat, 20 May 2023 11:13:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 20 May 2023 11:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684595636; x=1684682036; bh=aa
        3hX/fA0kw3zAvbLHpth1nKSHzqiH1/xoeSyjYa+44=; b=DjVIQbEEzF8gzFujZJ
        Ja8RZc6CYm7LRcuMbwXywCoX5IxQGZQDHzllM9s9KoZWL8NCgytF5HXZPayWcyH+
        h6hymDfvSRrP75/PknwFAMEELiXgtHlspEubEPRo8vxqJUoQ78ckzWD3FQHdcHMx
        HCNA1qpmTkWeJhWihk51TrrgSj+NUnC8w9AjsYrhRMKlGdflD1n7fzKeJifEEtPU
        OxjeHO/lRhIzi9L5CwE5YQlfNvWOGAv/ISoaQWaGVzNzPdgAJ34xkBm1O+eYV9Zw
        BL8N0CR/OP7eqpwHvJA8xLzurZmeE9h5W77AZ7fvslx7th7pQxFt9e4T/BHBHFNu
        L+rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684595636; x=1684682036; bh=aa3hX/fA0kw3z
        AvbLHpth1nKSHzqiH1/xoeSyjYa+44=; b=wtHrGm2xnbhXmTeF6BUoqV5Cn2tCC
        GkLrDXRIjQQ2J0vNbzWLjHmX7v0huaQy4Jw6IBySxuCpdyqxiZmSFmR73dA+y9Em
        g3ZkAoXcL1JPGVXfC8cHIzCCo1Pqz+eO8UiuyBOBzBJHCNlGX3II3Uio5IcPpI9L
        61aYN6OJj9rnTXWEGSDbtlMBSJrfUrNjs5baol3TkOJMoS3HUXd8G2MiPkcTEBal
        zJ9t9BuvMzS061gF7ZwnaBmAMXCq0egpYUP2JnlAaIUshDx/xuEaAejpRkAD0K9A
        hwkpPv3snDnn1OyAVnAs4DYSwRLUo3gvZsSrdHPG4pjoNcfiIlJ3Ri+kw==
X-ME-Sender: <xms:s-NoZDUIsOa1tSao4Iyq6Qvmtyu5s06f3FFYaE2Dmi3e9i4m3S6F2A>
    <xme:s-NoZLk4JS_vSdBtVkF-3LgHQMKFQt1Ypol3xfRZc8QWLA8_F32yNih4biX7pEC9n
    7jYRtnhUTjYUuOiNME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeijedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:s-NoZPa0uzMrugOx9Q6BU7YP9R_ncC9JfqCR7cZVMsn9dhswAS2VkA>
    <xmx:s-NoZOV8LBfOu4PdAOb3SIjMYiKIjWw_PbIgDDUK17qMNm1y7-KyfQ>
    <xmx:s-NoZNmvhsv9qHQvl6rtrSauiz7KYFsnh4sNQb8DHkOwedPt14aFpQ>
    <xmx:tONoZAtprfgNSXNA7rR5NZBQ3r6C2Lz36GZu3Gs80Q_-W5CZi1ZABw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B469DB60089; Sat, 20 May 2023 11:13:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <a98521a5-474a-44de-a95b-9a334b8f7fa4@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2305201531101.27887@angie.orcam.me.uk>
References: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
 <dae342ed-8999-4fa5-b719-322182580025@app.fastmail.com>
 <alpine.DEB.2.21.2305201531101.27887@angie.orcam.me.uk>
Date:   Sat, 20 May 2023 17:13:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Baoquan He" <bhe@redhat.com>,
        "Huacai Chen" <chenhuacai@kernel.org>
Subject: Re: [PATCH v4] mips: add <asm-generic/io.h> including
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 20, 2023, at 16:45, Maciej W. Rozycki wrote:
> 	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
> 		*__mem = __val;						\
> 	else if (cpu_has_64bits) {					\
> 		unsigned long __flags;					\
> 		type __tmp;						\
> 									\
> 		if (irq)						\
> 			local_irq_save(__flags);			\
> 		__asm__ __volatile__(					\
> 			".set	push"		"\t\t# __writeq""\n\t"	\
> 			".set	arch=r4000"			"\n\t"	\
> 			"dsll32 %L0, %L0, 0"			"\n\t"	\
> 			"dsrl32 %L0, %L0, 0"			"\n\t"	\
> 			"dsll32 %M0, %M0, 0"			"\n\t"	\
> 			"or	%L0, %L0, %M0"			"\n\t"	\
> 			"sd	%L0, %2"			"\n\t"	\
> 			".set	pop"				"\n"	\
> 			: "=r" (__tmp)					\
> 			: "0" (__val), "m" (*__mem));			\
> 		if (irq)						\
> 			local_irq_restore(__flags);			\
> 	} else								\
> 		BUG();							\
>
> etc. so we don't actually lose atomicity, because we always use 64-bit 
> operations (SD above, store-doubleword) and we BUG if they are not there 
> (i.e. with 32-bit hardware; not a build-time check as in principle the 
> same 32-bit kernel image ought to run just fine both on 32-bit and 64-bit 
> hardware).  A few MIPS platforms do use them, e.g. SB1250, which requires 
> 64-bit unswapped accesses to SoC registers.

Ok, makes sense.

     Arnd
