Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB48833A804
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 21:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhCNUlF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhCNUkr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 16:40:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32283C061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 13:40:47 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLXXU-00G7JU-Hy; Sun, 14 Mar 2021 21:40:40 +0100
Message-ID: <cf6713530642cdd11abc91a2ddb67f040c806aba.camel@sipsolutions.net>
Subject: Re: [RFC v8 12/20] um: lkl: initialization and cleanup
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 21:40:39 +0100
In-Reply-To: <031847ceca73023566fba8e84433a615eac6a2f3.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <031847ceca73023566fba8e84433a615eac6a2f3.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:
> 
> +	panic_blink = lkl_panic_blink;

Using a panic notifier would seem more appropriate?

> +	init_sem = lkl_sem_alloc(0);

what's the deal with this?

> +	if (!init_sem)
> +		return -ENOMEM;
> +
> +	ret = lkl_cpu_init();
> +	if (ret)
> +		goto out_free_init_sem;
> +
> +	ret = lkl_thread_create(lkl_run_kernel, NULL);
> +	if (!ret) {
> +		ret = -ENOMEM;
> +		goto out_free_init_sem;
> +	}
> +
> +	lkl_sem_down(init_sem);
> +	lkl_sem_free(init_sem);

You free it before the kernel really even started?

johannes

