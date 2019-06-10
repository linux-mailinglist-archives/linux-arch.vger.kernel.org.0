Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D386F3B23C
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbfFJJew (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 05:34:52 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:57636 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfFJJew (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 05:34:52 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 05:34:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4eGiVW2ASr/2wXgAHa/3aGTNnoVXeHPUusW8fdgt++Q=; b=M7VomCI51CoH28I3NAFr0m+ff
        rqBNddxfExXVFgwF3C5nLKikZV5mg+sHwE4Tfp//Q5KIcwLttOgWe4j5FZLf0gRBoD4HBCUpWzeqB
        82VIznHDYb1TwtgXrLgjo6TNRmmHxh/dk6u5BF3NIhDBpENDuClzKGnPwIuaqNH5DM8Ao=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1haGi6-0003ej-Mm; Mon, 10 Jun 2019 04:35:27 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1haGhT-0003A6-MO; Mon, 10 Jun 2019 10:34:47 +0100
Date:   Mon, 10 Jun 2019 10:34:47 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
Message-ID: <20190610093447.GC11076@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530141531.43462-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Score: -106.0
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Thu, May 30, 2019 at 03:15:15PM +0100, Vincenzo Frascino
    wrote: > With the definition of the unified vDSO library the implementations
    of > update_vsyscall and update_vsyscall_tz became quite simila [...] 
 Content analysis details:   (-106.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -100 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 03:15:15PM +0100, Vincenzo Frascino wrote:
> With the definition of the unified vDSO library the implementations of
> update_vsyscall and update_vsyscall_tz became quite similar across
> architectures.
> 
> Define a unified implementation of this two functions in kernel/vdso and

... of these two functions ...

> provide the bindings that can be implemented by every architecture that
> takes advantage of the unified vDSO library.
