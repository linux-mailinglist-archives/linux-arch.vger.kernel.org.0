Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E573DBD30
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhG3QnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhG3QnK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 12:43:10 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB4C06175F;
        Fri, 30 Jul 2021 09:43:05 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y4so10094376ilp.0;
        Fri, 30 Jul 2021 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bT/0Kzd2YZDLnX/zoL8eI8LS99wdxcWIOuQmVA36SH0=;
        b=ZcGRvxSrY8XdP3mdiMnSsHiydBE7qjQfB8raUtlkA6ssFveeYhGzg2uYiU1qdhCn4h
         nIneeHPCd9Z30jCFzRE/a7npaxYUN60cOCBe2im59+djftJRaDEGa007VYYyFthQGO+i
         alWZ5oAM3z/iTUJs6yuIyCbD+90VO8A0n27yKax9pLxuiPVU9PhjpyMmXmVqM8L/Qj7U
         RzFurSnxBC1aaILmliY4+lbn79ySZABJmwRPByhdKWeAEL6yVEeEGkRtb2FZc5Es17y1
         lI5c78zBQNN7ijzrLhEt8ZcUXdXy7aYvDo/QqS6vxYUVIqrVk1zjsui6vgWZHgL6NQJu
         IJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bT/0Kzd2YZDLnX/zoL8eI8LS99wdxcWIOuQmVA36SH0=;
        b=dyP1VFzVxU6OvYL3q1QtnSuwNmDN73A7tubXirFBh5E8rcVqNIyCUBViFlRErO10um
         jwXg/iaq7m1+WbXp6cacMEnXy6SQk1CkgyjuI4c+yrbEuYRWlukrUFV13vgcos6L1B3m
         U0QJ3IA6NYz0nOkuyh3ImKoyTisPwEpVrQxC7xE8hW5Ep5XFQamg2BiDu74uaoEqLXNo
         QdL+FdD6Yq0XvMYAObOxDA7Fc1H9f19UkV1TlxyfYzCGmbKOiBaedHgibfRo/NXuFIMq
         KeO73BGykkizR7Cc+rf1gb6/OTHq3YQ2vJVR/xLex9sO88sXu2DrWERidbU7F4le4ult
         VSpA==
X-Gm-Message-State: AOAM530/R7iAb40oF2Hl28HgjpHgb2bUthVHiDwEnK5CHjdHfjruRx7e
        G/nkITbmKymFtuOFm6inJXs=
X-Google-Smtp-Source: ABdhPJzD1MVMK0+xkWYxEsznSkNjsD4NRkF9kibxZVLKgsYFrSBndJ6t5/fyc9k2QfOA9BtPO6tXHw==
X-Received: by 2002:a92:6d07:: with SMTP id i7mr2509313ilc.104.1627663384509;
        Fri, 30 Jul 2021 09:43:04 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u12sm1028678ill.55.2021.07.30.09.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:43:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1E92127C005B;
        Fri, 30 Jul 2021 12:43:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Jul 2021 12:43:03 -0400
X-ME-Sender: <xms:FCwEYZ5D5Fp26xUCtvJImfbVcz_KVZe95Fm-rS1SMD3Ay8DI5ac3qw>
    <xme:FCwEYW7ajmmb5DOP370q57kPiH40JjmOLFsoyaDlgIdYbqmKs5qFA7dk-pHYRTJMY
    eecO-NVgV37hXpulw>
X-ME-Received: <xmr:FCwEYQct2gKVfjBfJTj0FarECVFZagcUUTgFBpx77xAzHReCAcPqRpNzF5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheehgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeuvddtudetleektdfhhfdvvedvudfgvddvhfetudffhfehieeukeekjeeugfduuden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FCwEYSLisBRyl0ztxw9Qb5az0zsxL_ShM26lDNE9bkkAa4GEZWuZTQ>
    <xmx:FCwEYdKYFuq1VUk6S0SxQ8O3ApPqTGXraSe_K3TD2MWCck51Fo3-pA>
    <xmx:FCwEYbxZanf1TlH8dPb9St7Cn9dX2mr1RHCe54IN5WW4BXIOmul3Gw>
    <xmx:FiwEYSrcOxdUyneyM-8ymNkNXyTCKiilYT2JWvnz0kbg6SH-9_88Hg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 12:43:00 -0400 (EDT)
Date:   Sat, 31 Jul 2021 00:42:34 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [Question] Alignment requirement for readX() and writeX()
Message-ID: <YQQr+twAYHk2jXs6@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

The background is that I'm reviewing Wedson's PR on IoMem for
Rust-for-Linux project:
	
	https://github.com/Rust-for-Linux/linux/pull/462

readX() and writeX() are used to provide Rust code to read/write IO
memory. And I want to find whether we need to check the alignment of the
pointer. I wonder whether the addresses passed to readX() and writeX()
need to be aligned to the size of the accesses (e.g. the parameter of
readl() has to be a 4-byte aligned pointer).

The only related information I get so far is the following quote in
Documentation/driver-io/device-io.rst:

	On many platforms, I/O accesses must be aligned with respect to
	the access size; failure to do so will result in an exception or
	unpredictable results.

Does it mean all readX() and writeX() need to use aligned addresses?
Or the alignment requirement is arch-dependent, i.e. if the architecture
supports and has enabled misalignment load and store, no alignment
requirement on readX() and writeX(), otherwise still need to use aligned
addresses.

I know different archs have their own alignment requirement on memory
accesses, just want to make sure the requirement of the readX() and
writeX() APIs.

Thanks a lot!

Regards,
Boqun
