Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16A54C27C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbiFOHMX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiFOHMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 03:12:22 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 00:12:21 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2C642A3B
        for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2022 00:12:21 -0700 (PDT)
Received: (qmail 2459 invoked from network); 15 Jun 2022 07:05:23 -0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69]:57486 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <hch@infradead.org>; Wed, 15 Jun 2022 09:05:23 +0200
MIME-Version: 1.0
Date:   Wed, 15 Jun 2022 09:05:17 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] arch/*: Disable softirq stacks on PREEMPT_RT.
In-Reply-To: <YqmC1aAm+O7RD2IH@infradead.org>
References: <YqjQ5kso7czrmYPW@linutronix.de>
 <YqmC1aAm+O7RD2IH@infradead.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ba5576b718dccb7e5e372ee9fa0a99a9@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 2022-06-15 08:57, schrieb Christoph Hellwig:
> On Tue, Jun 14, 2022 at 08:18:14PM +0200, Sebastian Andrzej Siewior 
> wrote:
>> Disable the unused softirqs stacks on PREEMPT_RT to safe some memory 
>> and
> 
> s/safe/save/

When we are at that point already:

> ensure that do_softirq_own_stack() is not used bwcause it is not

s/bwcause/because/
