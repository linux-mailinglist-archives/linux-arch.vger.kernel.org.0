Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14692861E7
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgJGPNL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGPNL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:13:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9AC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:13:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQB7n-000z4I-Jk; Wed, 07 Oct 2020 17:13:03 +0200
Message-ID: <0817bfdee3ee28ae8b94251ed559cf4e844a5ea4.camel@sipsolutions.net>
Subject: Re: [RFC v7 02/21] um: add os init and exit calls
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, Octavian Purdila <tavi@cs.pub.ro>,
        retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:13:02 +0200
In-Reply-To: <184f5b2c6a0c399edf519d27989519a35ab90700.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <184f5b2c6a0c399edf519d27989519a35ab90700.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> 
> -#define __define_initcall(level,fn) \
> -	static initcall_t __initcall_##fn __used \
> -	__attribute__((__section__(".initcall" level ".init"))) = fn
> -
> -/* Userspace initcalls shouldn't depend on anything in the kernel, so we'll
> - * make them run first.
> - */
> -#define __initcall(fn) __define_initcall("1", fn)
> +#undef __uml_exit_call
> +#define __uml_exit_call		__used __section(os_exitcalls)

Doesn't that break calling of sigio_cleanup and remove_umid_dir?

After all,

> +void __weak os_exitcalls(void)
> +{
> +}

This does nothing so far.

Also, why the __weak?

johannes

