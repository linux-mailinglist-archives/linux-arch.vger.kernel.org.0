Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C1689BD3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjBCOdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 09:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjBCOcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 09:32:53 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71849A81D;
        Fri,  3 Feb 2023 06:32:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A4A85C012D;
        Fri,  3 Feb 2023 09:32:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Feb 2023 09:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675434768; x=1675521168; bh=FALddAaYGF
        gcZ9rzGoq/Hl0U4sB28CXCpLkKlDzWrcc=; b=ImCPonV//aJmPtqPlGZhwlANPu
        91sIQWxvF5XKSi+wUqebKPHfTdT+6YwMbkPMNc8yiTUpX6flki7+ET8CC4fJx21+
        64oNWJmZRnfhOKIt1ilrrWnoHfH3nR1dYD3NpmZgjauUIT/RqUX/btwVEn1pcrLL
        o5s/SQ8t34eXcsieq5fhynfd3gsrEXekQ+UCJLdtIBMCzT6sDiPhtP5kBs5+VtjZ
        W1sqqJXbfYbnc8VASUlfz2VZEL+Bl5F5h/5XDqWZCPRbRVyykOUEplvVVLo+HjZK
        +A5VUCNxTNyZZRINTAnSbP0XS8zzRAnEc3KmwwLYXalQxwzPCMPVMefcaQ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675434768; x=1675521168; bh=FALddAaYGFgcZ9rzGoq/Hl0U4sB2
        8CXCpLkKlDzWrcc=; b=PirNOKqmbyM+NttfTfonhcvv1Hxev/Xgj75l6at0P5Az
        C+XPWBxRtOaixIsFcL3A9ZVndSBcS4piHn7MOyuMlYNwmPewhtqryNZVtDxBrDn4
        qPhvK3tf+WC2EfXoXMOIHcYcsrvLo6+sA/ODXg8ipYptBHQ9802+3cwewOYe1xAa
        Z/p96mcmC8obrDrBQxtClIw2RBHHjLRXXGLTEcmzUhpLfFp+iFYommwfMgUDJHyi
        425rUzepDaxi/w2iS8xaiAQDjAs33prSlRttTXK0Hxa+BqzXsle6GaXE+2PqcLWc
        YFXhHb2T/ruaj4ASoU/+OXUO8WCLHxas1VnMSWA2jQ==
X-ME-Sender: <xms:DxvdYy8Q4CgdiT1mETyUIm7EbLrVHOSH5J2jgNHoHIOqm_PFY-Cc3g>
    <xme:DxvdYys6O6sk1bfDXCBfYP7Jf_6-3pxfgKwvxjC-1c_U_93IBDwZrF8eyYIuBDS4Z
    6Eu02pEflOWxMVqkrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegtddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DxvdY4C-fv8ppXi9Lfee9yyz81cFTopC9fj1bq65wnj-WQ-OyIM--w>
    <xmx:DxvdY6eIAYvN-JP-wQVtfcsrWWLW1YrVVycIInqqPTPnLWINmWE_lw>
    <xmx:DxvdY3P9pJid1K3oB7cQm9qDtneeUwloVRYKL6oUsbIcRc0gucmPEA>
    <xmx:EBvdY91hjHPeBEO2Jr1Gq_e9h_uNvoeSrrf_ZeyDLMHth4IgjYq4Mg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5F98B6044F; Fri,  3 Feb 2023 09:32:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <a55d3d15-d89d-43c4-85e7-c6d18a57a32f@app.fastmail.com>
In-Reply-To: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
References: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
Date:   Fri, 03 Feb 2023 15:32:28 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Matt Evans" <mev@rivosinc.com>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: Re: [PATCH] locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare
 against zero-extended 'old' value
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 1, 2023, at 19:39, Matt Evans wrote:
> __generic_cmpxchg_local takes unsigned long old/new arguments which
> might end up being up-cast from smaller signed types (which will
> sign-extend).  The loaded compare value must be compared against a
> truncated smaller type, so down-cast appropriately for each size.
>
> The issue is apparent on 64-bit machines with code, such as
> atomic_dec_unless_positive(), that sign-extends from int.
>
> 64-bit machines generally don't use the generic cmpxchg but
> development/early ports might make use of it, so make it correct.
>
> Signed-off-by: Matt Evans <mev@rivosinc.com>
> ---

Applied to the asm-generic tree for 6.3, thanks

    Arnd
