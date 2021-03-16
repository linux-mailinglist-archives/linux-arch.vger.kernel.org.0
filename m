Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769F333E0AB
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhCPVgi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhCPVg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 17:36:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6AC06174A
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 14:36:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMHMS-00H63t-1T; Tue, 16 Mar 2021 22:36:20 +0100
Message-ID: <83c63df46b2a3d710a5ad48478ae12cefba44433.camel@sipsolutions.net>
Subject: Re: [RFC v8 13/20] um: lkl: integrate with irq infrastructure of UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Tue, 16 Mar 2021 22:36:19 +0100
In-Reply-To: <m21rcfc2sy.wl-thehajime@gmail.com> (sfid-20210316_022016_788128_95241D90)
References: <cover.1611103406.git.thehajime@gmail.com>
         <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
         <5e1f64997ffca8267bde7955fe2eb214dfb9e891.camel@sipsolutions.net>
         <m21rcfc2sy.wl-thehajime@gmail.com> (sfid-20210316_022016_788128_95241D90)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-03-16 at 10:20 +0900, Hajime Tazaki wrote:
> 
> > > -	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> > > -		panic("sigprocmask failed - errno = %d\n", errno);
> > > +	if (pthread_sigmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> > > +		panic("pthread_sigmask failed - errno = %d\n", errno);
> > 
> > UML doesn't normally link with libpthread, and LKL doesn't actually
> > appear to require it either (since it has its lkl_thread and all), so
> > this seems wrong?
> 
> I think both UML/LKL link with libpthread.  See old
> scripts/link-vmlinux.sh, or [01/20] patch.
> 
> -		${CC} ${CFLAGS_vmlinux}				\
> -			${strip_debug}				\
> -			-o ${output}				\
> -			-Wl,-T,${lds}				\
> -			${objects}				\
> -			-lutil -lrt -lpthread
> -		rm -f linux

Interesting. You're right, I really didn't expect that, nor did I ever
see that before.

How does this interact with all the clone() calls etc. that UML does?

johannes

