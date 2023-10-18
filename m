Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453FB7CD98C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjJRKtF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Oct 2023 06:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjJRKtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2023 06:49:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6092FF;
        Wed, 18 Oct 2023 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697626140;
        bh=3xWcji3oXjlN4cFukeLMtXQkcjmbOBmNuowH8WPgpqg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dSMsP/ETZci4Y90jENdqAUbUV4tg7l7t750Pe69hZMYUPqmlGGYZkb6yRIl8yDLFf
         /omnvBNpejjy8tnAf/mOpBbMrR0m2tpZeWAfIeIIRQdypgILcreVGx4IvLCdwQvtHi
         ZLDfUBUHEZFWV0Sla+UsS3dgFaDp0Zi9UHQoIcVWG8W1mpO4ksfZXApbK6uUIpJJCt
         ji5wtK6EjMbdd8GGudB8lG6dgOxPSl5YTC/nwHljwzatAAGxmIg931O54qvU7biaSQ
         2NZO2VolvUQmPCrtOlhRbYg15rfUsekBU39vQAMSXRUJLifgfmaFy0H70KXYAwXBsZ
         EZVZNNGZ9KphA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9SJT6JZtz4xPX;
        Wed, 18 Oct 2023 21:48:57 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Zimmermann <tzimmermann@suse.de>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, arnd@arndb.de, deller@gmx.de,
        javierm@redhat.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
In-Reply-To: <de09143e-ab7f-4ccc-8a5a-50e0f48c1b40@suse.de>
References: <20230922080636.26762-1-tzimmermann@suse.de>
 <de09143e-ab7f-4ccc-8a5a-50e0f48c1b40@suse.de>
Date:   Wed, 18 Oct 2023 21:48:54 +1100
Message-ID: <87a5sg6wa1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:
> FYI, I intent to merge patches 1 and 2 of this patchset into 
> drm-misc-next. The updates for PowerPC can be merged through PPC trees 
> later. Let me know if this does not work for you.

Hi Thomas,

Sorry for the late reply, I was on leave.

Yeah that's fine.

cheers

> Am 22.09.23 um 10:04 schrieb Thomas Zimmermann:
>> Clean up and rename fb_pgprotect() to work without struct file. Then
>> refactor the implementation for PowerPC. This change has been discussed
>> at [1] in the context of refactoring fbdev's mmap code.
>> 
>> The first two patches update fbdev and replace fbdev's fb_pgprotect()
>> with pgprot_framebuffer() on all architectures. The new helper's stream-
>> lined interface enables more refactoring within fbdev's mmap
>> implementation.
>> 
>> Patches 3 to 5 adapt PowerPC's internal interfaces to provide
>> phys_mem_access_prot() that works without struct file. Neither the
>> architecture code or fbdev helpers need the parameter.
>> 
>> v5:
>> 	* improve commit descriptions (Javier)
>> 	* add missing tags (Geert)
>> v4:
>> 	* fix commit message (Christophe)
>> v3:
>> 	* rename fb_pgrotect() to pgprot_framebuffer() (Arnd)
>> v2:
>> 	* reorder patches to simplify merging (Michael)
>> 
>> [1] https://lore.kernel.org/linuxppc-dev/5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com/
>> 
>> Thomas Zimmermann (5):
>>    fbdev: Avoid file argument in fb_pgprotect()
>>    fbdev: Replace fb_pgprotect() with pgprot_framebuffer()
>>    arch/powerpc: Remove trailing whitespaces
>>    arch/powerpc: Remove file parameter from phys_mem_access_prot code
>>    arch/powerpc: Call internal __phys_mem_access_prot() in fbdev code
>> 
>>   arch/ia64/include/asm/fb.h                | 15 +++++++--------
>>   arch/m68k/include/asm/fb.h                | 19 ++++++++++---------
>>   arch/mips/include/asm/fb.h                | 11 +++++------
>>   arch/powerpc/include/asm/book3s/pgtable.h | 10 ++++++++--
>>   arch/powerpc/include/asm/fb.h             | 13 +++++--------
>>   arch/powerpc/include/asm/machdep.h        | 13 ++++++-------
>>   arch/powerpc/include/asm/nohash/pgtable.h | 10 ++++++++--
>>   arch/powerpc/include/asm/pci.h            |  4 +---
>>   arch/powerpc/kernel/pci-common.c          |  3 +--
>>   arch/powerpc/mm/mem.c                     |  8 ++++----
>>   arch/sparc/include/asm/fb.h               | 15 +++++++++------
>>   arch/x86/include/asm/fb.h                 | 10 ++++++----
>>   arch/x86/video/fbdev.c                    | 15 ++++++++-------
>>   drivers/video/fbdev/core/fb_chrdev.c      |  3 ++-
>>   include/asm-generic/fb.h                  | 12 ++++++------
>>   15 files changed, 86 insertions(+), 75 deletions(-)
>> 
>> 
>> base-commit: f8d21cb17a99b75862196036bb4bb93ee9637b74
>
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
