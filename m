Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021FF48C1BD
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 10:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiALJ4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 04:56:44 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:36970 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiALJ4h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 04:56:37 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8F26A20C5FE3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: consolidate the compat fcntl definitions
To:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
CC:     Guo Ren <guoren@kernel.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
References: <20220111083515.502308-1-hch@lst.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4ae57b3d-0758-1a05-b743-c46a97d09e5e@omp.ru>
Date:   Wed, 12 Jan 2022 12:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On 1/11/22 11:35 AM, Christoph Hellwig wrote:

> currenty the compat fcnt definitions are duplicate for all compat

   fcntl?

> architectures, and the native fcntl64 definitions aren't even usable
> from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
> to sort out all that.

[...]

MBR, Sergey
