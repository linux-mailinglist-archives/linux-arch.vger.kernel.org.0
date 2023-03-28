Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495F6CBDEB
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjC1Lgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjC1Lgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 07:36:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C715BA1
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2023 04:36:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 01AB65C0151;
        Tue, 28 Mar 2023 07:36:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 28 Mar 2023 07:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680003400; x=1680089800; bh=XV
        I90BRA2VCb0GKb2J+B4g3wZ/hX5qeVkvOPQlWD9SQ=; b=d2WuWRp5qX6sHjqYNv
        xPoxgO7gWSQnKlfcCO8oRpcOtQD77IuAzzhb/w6OygGYnzvOtwE3Ip34uNiXPFwS
        ackZHVo4BSFgXzEGHAel0dUu1ISJXoQXfSmEeexOKsMEO0JYyjJzbFuaub5QmMHb
        rScKmhg7devqvfUu0J9sWk49Jlk9cKIZkOInE/gilfbDfA+I/HUpBJYcZmDNX5Kc
        LpB7l4c739+E3pSrJwQeb5M5vQ2t4ODfF34olXzi0XlIch1uYjgmRgdRbcYno+a1
        qEuO6dMxZebn/Wk+F5s7l2uQDO+3p2xr5GOReItAu+u/LKfKcBrgUTnopwiWN2d9
        +XJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680003400; x=1680089800; bh=XVI90BRA2VCb0
        GKb2J+B4g3wZ/hX5qeVkvOPQlWD9SQ=; b=SjAU2T5me+u6GCDoMgrwcEkhZ5GiJ
        6mdcmEzNF5V3n3i7+uAkaC00wJ1bqslOfurMjGsTQNSBMBIjBn2PPrHBD36odIJH
        Hn+mYYQlmH9CQ5tCaCF9zO7YHcTCFUuArZsOpB97aM7fU8V/rmhy0oIJT/MqX9C1
        21jrBJqM80DOjj5TUSWqRypqXPdgmvbmmzjlhbc8U74wl3WetK9mvayfFlbwwo/s
        2O2RA3hNbyhcVgA56VED8AQDG3IG7JIrR38Ad57RJv8b/hX8jrQRsSSE/HyDtvzJ
        TEfDq9fqJl+YhVO4bB/WDlLJKBdcMcRiH9sZ7PlX7EGr4BIzRvtoAOUOA==
X-ME-Sender: <xms:SNEiZMBmOqitKFSEHtLb2E_Nn6pfXsqvE2eEmMEFYSzslm8ICPwIIA>
    <xme:SNEiZOhbJJrwlvxlpF-pF3-8Ozk1LBl0wRqcVuLoBpb2zoYF8aH3q1tcUpA-5sYKb
    iaimncpxUibRXhF_M0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SNEiZPnpTS1ERzMJ0irUxdwXdNBE2G9VIjDVzkZ0GBRMTNXBMHABhg>
    <xmx:SNEiZCzB0S5VXBE0gFq-UQ0yZn8BYKYF5BYzCVmLQAWfneMn6AQVAw>
    <xmx:SNEiZBSMsNu-q94csk0SprK6s2wXA5U3or-UEFnw7LutyP709oErdA>
    <xmx:SNEiZAJGt6o8SrSapX0ozajr-R0lFlU8bziclwJP2HMwcaui2s9zXA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C35C3B60092; Tue, 28 Mar 2023 07:36:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <f8741854-1466-4cb6-9c29-c26e7ac4a5de@app.fastmail.com>
In-Reply-To: <202303281326.s4BXzpx2-lkp@intel.com>
References: <202303281326.s4BXzpx2-lkp@intel.com>
Date:   Tue, 28 Mar 2023 13:36:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [arnd-asm-generic:dma-sync-rework-v1 22/23]
 arch/arm/mm/dma-mapping.c:1306:31: error: use of undeclared identifier 's'
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 28, 2023, at 07:28, kernel test robot wrote:
>
>>> arch/arm/mm/dma-mapping.c:1306:31: error: use of undeclared identifier 's'
>                    arch_sync_dma_for_cpu(phys, s->length, dir);
>                                                ^
>    arch/arm/mm/dma-mapping.c:1309:29: error: use of undeclared 
> identifier 's'
>                    arch_dma_mark_clean(phys, s->length);
>                                              ^
>    arch/arm/mm/dma-mapping.c:1436:6: warning: unused variable 'len' 

Fixed now, thanks for the report.

     Arnd
