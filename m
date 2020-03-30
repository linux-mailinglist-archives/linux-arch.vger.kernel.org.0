Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39B319868F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgC3VbV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 17:31:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43644 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgC3VbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 17:31:20 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJ204-0073Cz-Pp; Mon, 30 Mar 2020 23:31:17 +0200
Message-ID: <b2a730a4bcafb13cb1b29a637f8f8449cf3521d6.camel@sipsolutions.net>
Subject: Re: [RFC v4 23/25] um lkl: add UML network driver for lkl
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Akira Moroo <retrage01@gmail.com>
Date:   Mon, 30 Mar 2020 23:31:15 +0200
In-Reply-To: <0f087b36ad579eeb8062b12e9e61566d9b5b18ac.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
         <0f087b36ad579eeb8062b12e9e61566d9b5b18ac.1585579244.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> +++ b/arch/um/lkl/include/asm/irq.h
> @@ -2,6 +2,9 @@
>  #ifndef _ASM_LKL_IRQ_H
>  #define _ASM_LKL_IRQ_H
>  
> +/* pull UML's definitions */
> +#include "../../../include/asm/irq.h"

This is _really_ ugly.

> +#if defined(__linux) && (defined(__i386) || defined(__x86_64))
> +#include <os.h>
> +#endif
> +void *um_os_signal(int signum, void *handler);

and arguably those random declarations you're sprinkling are worse.

> @@ -181,6 +196,11 @@ void init_IRQ(void)
>  	for (i = 0; i < NR_IRQS; i++)
>  		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
>  
> +#if defined(__linux) && (defined(__i386) || defined(__x86_64))

What's with all those ifdefs with this condition?

> +++ b/tools/lkl/lib/um/um_glue.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +
> +
> +char lkl_um_devs[4096];
> +
> +/* from sigio.c */
> +void maybe_sigio_broken(int fd, int read)
> +{
> +}
> +
> +/* from process.c */
> +int os_getpid(void)
> +{
> +	return getpid();
> +}

All of this really is quite ugly - are you sure it's needed for just the
vector network driver??

johannes

