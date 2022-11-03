Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AC617EBB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiKCOBd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiKCOBJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 10:01:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843415A19;
        Thu,  3 Nov 2022 07:00:54 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7e7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DBF31EC0528;
        Thu,  3 Nov 2022 15:00:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667484053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4bHId7434eLVFnjTAfALLhKy/saTSu8N63Jtf8EcS/A=;
        b=FgAuBkgdJGr2GoF1eROncSdsrl+L33PYjhXosgyJHxRe8uT6w+pBPGkBqPhXY228enLLS+
        K+/B4fFpOFHQvu51ByqpEclhUk8edClIZUJ9qnJzJzLqzrAH+FDfJX6Bzsb3FPPNhKtM8u
        BiKLBZ49FN1uZxgF1rvXUKr+pSt7F5I=
Date:   Thu, 3 Nov 2022 15:00:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v3 0/5]  Add support running nested Microsoft Hypervisor
Message-ID: <Y2PJkW12g7yeNzI4@zn.tnic>
References: <https://lore.kernel.org/linux-hyperv/cover.1667406350.git.jinankjain@linux.microsoft.com/T/#t>
 <cover.1667480257.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667480257.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 03, 2022 at 01:04:02PM +0000, Jinank Jain wrote:
> ...

Please stop spamming people with patches every day:

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^
one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

busy times like merge windows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
