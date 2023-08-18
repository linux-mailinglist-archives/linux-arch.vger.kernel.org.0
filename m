Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21217815AA
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbjHRXIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbjHRXIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:08:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2EE4D;
        Fri, 18 Aug 2023 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LZRegAIROXzZcs6sU84B7SbtZZCoef4fDxKDjhh4irI=; b=jdWFCFbZODmxVzFWdoTI9O2FUZ
        LP163Ww3plYQyuXOuCX4kBW102YAtQPG9t2P30poUbzum44SEHT8gnFbqIOXz5II8JMORQo2h33vb
        tCIqxpDF100+vGFjppYnqKQZpEC3DQk5XPZc7A1sNyZ2P1ddLKz3uSA57PpNI7dBJYrPtbGWSdCwP
        hb5HntJ7c/VWIsblxRnQG95t+nyDe4hpjHzPQ4C8lwzUdvKUgC6dUjVRnMKKoDlX8VCMXbMU4jBLt
        YvNieNNbXPsjlxmtsXDH5Z+w+DMxpFrYf5F9qbQVphJRmXpqrGlc29g/qJ792Qq2Po55FCXVLZFOU
        BGqruOyA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qX8Zj-00A8u5-1J;
        Fri, 18 Aug 2023 23:08:15 +0000
Message-ID: <3a5898a1-71b3-7377-cf46-94149e53cbce@infradead.org>
Date:   Fri, 18 Aug 2023 16:08:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/1] asm-generic: Fix spelling of architecture
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20230724134301.13980-1-andriy.shevchenko@linux.intel.com>
 <ZN+V7P6srKrAelUQ@smile.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZN+V7P6srKrAelUQ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 8/18/23 09:01, Andy Shevchenko wrote:
> On Mon, Jul 24, 2023 at 04:43:01PM +0300, Andy Shevchenko wrote:
>> Fix spelling of "architecture" in the Kbuild file.
> 
> Any comments?
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy
