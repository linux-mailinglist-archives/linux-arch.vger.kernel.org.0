Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67647B86FB
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 19:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjJDRwc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjJDRwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 13:52:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6EA6;
        Wed,  4 Oct 2023 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mo3SyRE4KU0QzJxDQXUPBvxPA9G+jjLznhNMOrDLoDM=; b=3oPq2TOpYHgcYcsR7E5Nqtt1vb
        T+i6KveGE0ktmSIadiY0DVB5ch9450DddZ4PdOqS+iDOcflTW9MTdMbG2C9YxRpIRmujoHdyPPjPw
        /O7lOjglJY+zq6RK08F7n54ZIaftQQDDOhmMuhktVpOSRLs/VohqILMBaF0R4HUGqBdpq425dOOux
        XcqG4QYfjj+FqCZv8aoWbPJIRZuGxs9RefI/o/spj1wMzqg9Upun3oVoElRDgpRXva+S2VOR7lcA2
        Igd0LyObVOa33uIY7JTQl0zRXQociPYtkdOH7Mzb0yKGkuv8jo4psZcwa8lreWLg8edPkVQmUa7Bq
        gKqQ9xFQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qo62q-000dsZ-24;
        Wed, 04 Oct 2023 17:52:24 +0000
Message-ID: <2d690a95-67c6-45cb-91a1-4fbac09e1224@infradead.org>
Date:   Wed, 4 Oct 2023 10:52:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
Content-Language: en-US
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
References: <20231004165804.659482-1-stephen.s.brennan@oracle.com>
 <20231004165804.659482-2-stephen.s.brennan@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231004165804.659482-2-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 10/4/23 09:58, Stephen Brennan wrote:
> The option CONFIG_IKCONFIG allows the gzip compressed kernel
> configuration to be included into vmlinux or a module. In these cases,
> debuggers can access the config data and use it to adjust their behavior
> according to the configuration. However, distributions rarely enable
> this, likely because it uses a fair bit of kernel memory which cannot be
> swapped out.

x86_64 allmodconfig is 91 KB gzipped... oh well.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> This means that in practice, the kernel configuration is rarely
> available to debuggers.
> 
> So, introduce an alternative, CONFIG_DEBUG_INFO_IKCONFIG. This strategy,
> which is only available if IKCONFIG is not already built-in, adds a
> section ".debug_linux_ikconfig", to the vmlinux ELF. It will be stripped
> out of the final images, but will remain in the debuginfo files. So
> debuggers which rely on vmlinux debuginfo can have access to the kernel
> configuration, without incurring a cost to the kernel at runtime.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  3 ++-
>  kernel/Makefile                   |  1 +
>  kernel/configs-debug.S            | 18 ++++++++++++++++++
>  lib/Kconfig.debug                 | 14 ++++++++++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/configs-debug.S


-- 
~Randy
