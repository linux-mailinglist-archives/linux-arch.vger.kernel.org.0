Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9024D480316
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhL0R5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:57:47 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:42760 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhL0R5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 12:57:47 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 12:57:46 EST
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id DB6A22B0;
        Mon, 27 Dec 2021 18:52:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a87sJkm--fNp; Mon, 27 Dec 2021 18:52:18 +0100 (CET)
Received: from begin.home (2a01cb0088600700de41a9fffe47ec49.ipv6.abo.wanadoo.fr [IPv6:2a01:cb00:8860:700:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 139E5281;
        Mon, 27 Dec 2021 18:52:18 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1n1uAT-00CRly-7Q;
        Mon, 27 Dec 2021 18:52:17 +0100
Date:   Mon, 27 Dec 2021 18:52:17 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [RFC 06/32] speakup: Kconfig: add HAS_IOPORT dependencies
Message-ID: <20211227175217.5bnpoauk2e3ni73s@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        speakup@linux-speakup.org
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-7-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227164317.4146918-7-schnelle@linux.ibm.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr;
        none
X-Rspamd-Queue-Id: DB6A22B0
X-Spamd-Result: default: False [1.90 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_TWELVE(0.00)[20];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_LAST(0.00)[];
         FREEMAIL_CC(0.00)[kernel.org,google.com,huawei.com,andestech.com,gmail.com,sifive.com,dabbelt.com,eecs.berkeley.edu,the-brannons.com,reisers.ca,vger.kernel.org,lists.infradead.org,linux-speakup.org];
         MID_RHS_NOT_FQDN(0.50)[];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Niklas Schnelle, le lun. 27 déc. 2021 17:42:51 +0100, a ecrit:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. SPEAKUP_SERIALIO thus needs to depend on HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accessibility/speakup/Kconfig b/drivers/accessibility/speakup/Kconfig
> index 07ecbbde0384..e84fb617acc4 100644
> --- a/drivers/accessibility/speakup/Kconfig
> +++ b/drivers/accessibility/speakup/Kconfig
> @@ -46,6 +46,7 @@ if SPEAKUP
>  config SPEAKUP_SERIALIO
>  	def_bool y
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  
>  config SPEAKUP_SYNTH_ACNTSA
>  	tristate "Accent SA synthesizer support"
> -- 
> 2.32.0
> 

-- 
Samuel
	/* Amuse the user. */
	printk(
"              \\|/ ____ \\|/\n"
"              \"@'/ ,. \\`@\"\n"
"              /_| \\__/ |_\\\n"
"                 \\__U_/\n");
(From linux/arch/sparc/kernel/traps.c:die_if_kernel())
