Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45832FD522
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 17:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhATQLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 11:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbhATQKE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 11:10:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C038C061757;
        Wed, 20 Jan 2021 08:09:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2G2o-009CDI-D1; Wed, 20 Jan 2021 17:09:18 +0100
Message-ID: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
Subject: Re: [PATCH] init/module: split CONFIG_CONSTRUCTORS to fix module
 gcov on UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 20 Jan 2021 17:09:01 +0100
In-Reply-To: <8191aa4a-3bd7-5de7-1ad2-73b851128ff3@linux.ibm.com>
References: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
         <8191aa4a-3bd7-5de7-1ad2-73b851128ff3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 17:07 +0100, Peter Oberparleiter wrote:

> Do you expect other users for these new config symbols? 

Probably not.

> If not it seems
> to me that the goal of enabling module constructors for UML could also
> be achieved without introducing new config symbols.

Yeah, true.

> For example you could suppress calling any built-in kernel constructors
> in case of UML by extending the ifdef in do_ctors() to depend on both
> CONFIG_CONSTRUCTORS and !CONFIG_UML (maybe with an explanatory comment).
> 
> Of course you'd still need to remove the !UML dependency in
> CONFIG_GCOV_KERNEL.

Right.

I can post a separate patch and we can see which one looks nicer?

johannes


