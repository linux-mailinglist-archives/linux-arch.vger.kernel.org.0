Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410EB33A80E
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 21:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhCNUp5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 16:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhCNUpf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 16:45:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720AC061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 13:45:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLXc3-00G7P7-U5; Sun, 14 Mar 2021 21:45:24 +0100
Message-ID: <5e1f64997ffca8267bde7955fe2eb214dfb9e891.camel@sipsolutions.net>
Subject: Re: [RFC v8 13/20] um: lkl: integrate with irq infrastructure of UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 21:45:23 +0100
In-Reply-To: <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:
>  static irqreturn_t um_timer(int irq, void *dev)
>  {
> +#ifndef CONFIG_UMMODE_LIB
>  	if (get_current()->mm != NULL)

Why is the ifdef needed - get_current()->mm should always be NULL for
LKL? Surely get_current() must still work?

>  	sigemptyset(&sig_mask);
>  	sigaddset(&sig_mask, sig);
> -	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> -		panic("sigprocmask failed - errno = %d\n", errno);
> +	if (pthread_sigmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> +		panic("pthread_sigmask failed - errno = %d\n", errno);

UML doesn't normally link with libpthread, and LKL doesn't actually
appear to require it either (since it has its lkl_thread and all), so
this seems wrong?

johannes

