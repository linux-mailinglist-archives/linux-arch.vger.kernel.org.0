Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA92FD8B6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 19:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbhATSqr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 13:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbhATRji (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 12:39:38 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D08C061786;
        Wed, 20 Jan 2021 09:38:34 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2HR9-009EAp-Fv; Wed, 20 Jan 2021 18:38:31 +0100
Message-ID: <34643068c072c185cc9a65f2c3e643be5169136d.camel@sipsolutions.net>
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-um@lists.infradead.org
Date:   Wed, 20 Jan 2021 18:38:15 +0100
In-Reply-To: <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
         <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
         <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 18:04 +0100, Peter Oberparleiter wrote:
> 
> > Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
> > the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
> > from the reset file), and with it we get the files and they work.
> 
> Just to be sure: could you confirm that this test statement for UML also
> applies to v2, i.e. that it fixes the original problem you were seeing?

Yes, I tested this version too :)

johannes

