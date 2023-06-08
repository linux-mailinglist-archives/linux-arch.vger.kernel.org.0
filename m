Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE66D7281A2
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjFHNpQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjFHNpP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705826AB
        for <linux-arch@vger.kernel.org>; Thu,  8 Jun 2023 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686231874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8YOm/Wq0xQ/f+nLG8S3hOURNC7q6SK7Qr+0HSWMgLNg=;
        b=Ser92o5D1BWMx46DEhd09GtatGdPxx6I/wiLfK/ZeA3PP0ZfmtR/Odcj0QVPerpcFaDdRj
        Jwa/JOlOT/cAOYJ4tn3ioEnKhAYM8BdviXyozVUAj+CCyOFBCFG7xLyWhe1Au7Umz3nZX7
        1EcnJMvri0fbsrJS++GTFG+LXkzCfV8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414--xyoGopsMAmqyFugNWrd1g-1; Thu, 08 Jun 2023 09:44:33 -0400
X-MC-Unique: -xyoGopsMAmqyFugNWrd1g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62621cdb1f0so7018766d6.0
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2023 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686231872; x=1688823872;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YOm/Wq0xQ/f+nLG8S3hOURNC7q6SK7Qr+0HSWMgLNg=;
        b=dsnsQnO8klsm9iU0LB1SkWiZPX9mJbUL8roFig9no73jRg0ASbBBYMelWgUI0yWGDE
         7iA32cj4rsKxvDNN4N0xMEMoCetfavjlvXkeRqQDBIPhecWXQdWL+fiqnsK48nidV6b2
         wnwPJDWJ6O17zObmPJ/+vyeimEsN7aOySoVdPS4HxcGLUVxHeARtqdjnmNdqH0HpkwIe
         vPxdV65x/rrs8Wgr65uQ2REPni5EEA6aYaJAeIdWINy+vWOPV2pC5QNXaNz6+Sb+PlKw
         SHQA7JgX9rhwttZ8eH5Fo6u53olrUaOhL1HLxULcdeJ/XVqgCg+grmH0NgQvVyYBRmaj
         prrg==
X-Gm-Message-State: AC+VfDzPAObMTlfR8OwZJQL1F77XBz4/n5XJGnkx2HQKGYCHn0GS0kWu
        sCRa2yqX+Q67oNqSqtZrfoR3N/pHw4hiqrcnkMdWTIWsAJmgfnCV6MNqfCi0VqK1fj1Cms+Dui9
        BPdXSBnrZAi6y7g9t2o/Lwg==
X-Received: by 2002:a05:6214:cac:b0:623:66ee:79b2 with SMTP id s12-20020a0562140cac00b0062366ee79b2mr1756869qvs.36.1686231872649;
        Thu, 08 Jun 2023 06:44:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5A2C40pJOWAeAfGPq9ZdpAs1lkgBc1Htg+VY1e2LQ46fr1nqLpB/LfJtD43nPGY6v0oKmm/A==
X-Received: by 2002:a05:6214:cac:b0:623:66ee:79b2 with SMTP id s12-20020a0562140cac00b0062366ee79b2mr1756847qvs.36.1686231872356;
        Thu, 08 Jun 2023 06:44:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id h9-20020a0cf209000000b0062884fd5fbfsm418979qvk.21.2023.06.08.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:44:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
In-Reply-To: <BYAPR21MB16883BF49ED337A6EF063461D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-4-ltykernel@gmail.com> <873536ksye.fsf@redhat.com>
 <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com>
 <87o7lsk2v8.fsf@redhat.com>
 <BYAPR21MB16883BF49ED337A6EF063461D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Thu, 08 Jun 2023 15:44:27 +0200
Message-ID: <87y1ku2hms.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, June 6, 2023 8:49 AM
>> 
>> Tianyu Lan <ltykernel@gmail.com> writes:
>> 
>> > On 6/5/2023 8:13 PM, Vitaly Kuznetsov wrote:
>> >>> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>> >>>
>> >>>   	}
>> >>>   	if (!WARN_ON(!(*hvp))) {
>> >>> +		if (hv_isolation_type_en_snp()) {
>> >>> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>> >>> +			memset(*hvp, 0, PAGE_SIZE);
>> >>> +		}
>> >> Why do we need to set the page as decrypted here and not when we
>> >> allocate the page (a few lines above)?
>> >
>> > If Linux root partition boots in the SEV-SNP guest, the page still needs
>> > to be decrypted.
>
> We have code in place that prevents this scenario.  We don't allow Linux
> in the root partition to run in SEV-SNP mode.  See commit f8acb24aaf89.
>
>> >
>> 
>> I'd suggest we add a flag to indicate that VP assist page was actually
>> set (on the first invocation of hv_cpu_init() for guest partitions and
>> all invocations for root partition) and only call
>> set_memory_decrypted()/memset() then: that would both help with the
>> potential issue with KVM using enlightened vmcs and avoid the unneeded
>> hypercall.
>> 
>
> I think there's actually a more immediate problem with the code as
> written.  The VP assist page for a CPU is not re-encrypted or freed when
> a CPU goes offline (for reasons that have been discussed elsewhere).  So
> if a CPU in an SEV-SNP VM goes offline and then comes back online, the
> originally allocated and already decrypted VP assist page will be reused.
> But bad things will happen if we try to decrypt the page again.
>
> Given that we disallow the root partition running in SEV-SNP mode,
> can we avoid the complexity of a flag, and just do the decryption and
> zero'ing when the page is allocated?

Sure, makes perfect sense but let's leave a [one line] comment why we
don't do any decryption for root partition then.

-- 
Vitaly

