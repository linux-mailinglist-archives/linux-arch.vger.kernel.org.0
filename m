Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483AD378AD0
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhEJLwq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhEJLjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 07:39:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C87C06138B;
        Mon, 10 May 2021 04:38:01 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lg4EU-006y0Y-BN; Mon, 10 May 2021 13:37:54 +0200
Message-ID: <2a46ca787df9a44c8b4fbc17ab6b69247ab38400.camel@sipsolutions.net>
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lambert <lambertdev@qq.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-um@lists.infradead.org, "Lambert." <lambertdev@foxmail.com>
Date:   Mon, 10 May 2021 13:37:53 +0200
In-Reply-To: <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
         <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
         <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
         <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> Hi Johannes and Peter, sorry to bother but I have one question 
> on this change. The do_ctors() won’t be executed for UML 
> because  *the constructors have already been called for ELF*. 
> 
> *__ctors_start*  and  *__ctors_end* symbols. See link:
> https://elixir.bootlin.com/linux/v5.12.2/source/include/asm-generic/vmlinux.lds.h#L676
> 
> In my environment, UML+GCC 10, I can't find __gcov_init executed 
> before kernel starts. So I did some trace and found glibc
> __libc_csu_init 
> will only execute constructors between *__init_array_start*and
> *__init_array_end*.  
> Which means if do_ctors() is not executed for UML, no elsewhere will 
> the constructors be executed.
> 
> Shall we remove the *!defined(CONFIG_UML)* for GCC, or I just missed 
> some steps to make the GCOV work for UML? 

No, that doesn't seem like the right solution.

Perhaps then with that toolchain (or configuration thereof) we need to
provide __init_array_start/end labels?

Or ... maybe that actually just needs to be removed, so that the
toolchain gets to choose?

Hmm. Pretty sure it worked for me, I think also with gcc 10, but not
sure exactly where I tested.

johannes


