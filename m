Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E633A80A
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCNUnP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhCNUnC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 16:43:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9BC061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 13:43:01 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLXZd-00G7LW-C5; Sun, 14 Mar 2021 21:42:53 +0100
Message-ID: <1aebaecdb4c5b3e62f5a89618b9d13f237d6b3c1.camel@sipsolutions.net>
Subject: Re: [RFC v8 11/20] um: lkl: basic console support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 21:42:52 +0100
In-Reply-To: <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> 
> -obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
> +ifndef CONFIG_UMMODE_LIB
> +obj-y := stdio_console.o
> +else
> +obj-y :=
> +endif
> +obj-y += fd.o chan_kern.o chan_user.o line.o

Might nicer to do via Kconfig, such as

config STDIO_CONSOLE
	def_bool y
	depends on !UMMODE_LIB

and then

obj-$(CONFIG_STDIO_CONSOLE) += stdio_console.o

here. Similar to CONFIG_STDDER_CONSOLE, after all.
> +/**
> + * lkl_print - optional operation that receives console messages

How is it optional? I don't see you having a __weak definition?

johannes

