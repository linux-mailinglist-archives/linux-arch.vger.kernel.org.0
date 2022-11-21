Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6E632F44
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 22:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKUVs6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 16:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiKUVso (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 16:48:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED40D5A31;
        Mon, 21 Nov 2022 13:48:43 -0800 (PST)
Received: from zn.tnic (p200300ea9733e79b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e79b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 027871EC042F;
        Mon, 21 Nov 2022 22:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669067322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J5SWJvr0UGvOa/JZXWNszN+UaejYkZ4rft/+lYhdF24=;
        b=k1+tJGubsxUdxG62ZW48K2Y1BTyEvxS9MHUxVD/YOd3ij3ZhkU29F65m/HwuhioYjJgUZR
        zdIz4XFr9w+wyYWTrWNEm5SMrqeA+dNFqCXqPfxwr2oaBucjuVzny+NyYySNwaNP2QkRUE
        dcffzj8ZfpUTSriRvULz3Y9OVJijRuM=
Date:   Mon, 21 Nov 2022 22:48:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/hyperv: Add hv_isolation_type_tdx() to detect
 TDX guests
Message-ID: <Y3vyNDpcR5+nScdw@zn.tnic>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-5-decui@microsoft.com>
 <d5f95b6b-df7f-416f-14c0-b4e284125d2a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5f95b6b-df7f-416f-14c0-b4e284125d2a@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022 at 01:01:45PM -0800, Dave Hansen wrote:
> On 11/21/22 11:51, Dexuan Cui wrote:
> > +			switch (hv_get_isolation_type()) {
> > +			case HV_ISOLATION_TYPE_VBS:
> > +			case HV_ISOLATION_TYPE_SNP:
> >  				cc_set_vendor(CC_VENDOR_HYPERV);
> > +				break;
> > +
> > +			case HV_ISOLATION_TYPE_TDX:
> > +				static_branch_enable(&isolation_type_tdx);
> > +				break;
> 
> This makes zero logical sense to me.
> 
> Running on Hyper-V, a HV_ISOLATION_TYPE_SNP is CC_VENDOR_HYPERV, but a
> HV_ISOLATION_TYPE_TDX guest is *NOT* CC_VENDOR_HYPERV?

https://lore.kernel.org/r/Y3uTK3rBV6eXSJnC@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
