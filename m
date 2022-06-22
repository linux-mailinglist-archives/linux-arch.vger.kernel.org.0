Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDC55523E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377009AbiFVRTz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376717AbiFVRTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 13:19:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F291F2CB
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 10:19:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e5so9633601wma.0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g7rgKaNRu6VI+rL2tcZJVezyj5b7Lszc6RDU2QcG3NQ=;
        b=Dsp3eLP695OxhLmAxgCpTladrks0d9cl3c4pqEG8IsiuYRxlbmyT9zMcfK+VdJOEhP
         vqcEAnywIUG3D4hOvDO4vgW7mTKDWa4FOUacvv0rZZ1u/SO4iaTUMJT1YLVZARqV4UnP
         VVaOZc6pGpqsRfWobvfoyII6hejsz2rE4brC494B2LoC31jIRjDfn1jZaLdHctRIJGTs
         eYVx6Mr13FW6Ezg18RcNdgljwra6zUmgwIfkDvEWL26pByjsiHrTuzgpz4XG6qL9VH6q
         2R9XZ6ufukStzJFEMcZ2MrXmX7/nzP3kY80P4OPxqAvqF9i9lBRjwSybCsaRqRMoajR9
         c2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g7rgKaNRu6VI+rL2tcZJVezyj5b7Lszc6RDU2QcG3NQ=;
        b=Z1v+fVHPv2WZ7XEaxb4/QX140V4HbevTnqzuVAdVoAR7PE9tvcxJQO3jLuVnjKFqmI
         ka3NsXPwDVPHCgs65wEPa+MULdrE/Sj+efTHnoqkYtMQH9FiTBaKaVKoQty8N0dMIIdW
         ntq8XA1AxwoXpyYLhAI5iUmXdFhA+fhMrJp6jmfQN097oPlnOrQ6WNOlFCXo6mr31dBi
         9/R2gMGGFimqwUjnSxqBWW7IfRySDYsw1cS2AL4wuctEsXj0IW4O5jJe15Pu/kjPQfzW
         SRn/j/xc19C/HAcDYJcrtV/TacOMEpdXVL7LT/QdPKZ58DJrlN3QYQdJkP3PXdpSUVYf
         pdew==
X-Gm-Message-State: AOAM533YiRwzSe7WiZoS9OD4k4Mi17A3S4oDVRiOX/ZielqWDaO5Du2a
        dHoO56HZ7u7MddPJbxXyisxVpA==
X-Google-Smtp-Source: ABdhPJzonljILXzP/YeUVGmI5wxNQjklVcp+NVX87qobxoQHEtny1OoVzedlkPsbhH9Zvj4Jv4dkKA==
X-Received: by 2002:a05:600c:3229:b0:39c:65b2:8935 with SMTP id r41-20020a05600c322900b0039c65b28935mr48023528wmp.155.1655918390841;
        Wed, 22 Jun 2022 10:19:50 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c42d200b003a02b9c47e4sm26041wme.27.2022.06.22.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:19:49 -0700 (PDT)
Date:   Wed, 22 Jun 2022 18:19:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, mark.rutland@arm.com,
        pasha.tatashin@soleen.com, broonie@kernel.org,
        rmk+kernel@armlinux.org.uk, madvenka@linux.microsoft.com,
        christophe.leroy@csgroup.eu
Subject: Re: [PATCH v5 00/33] objtool: add base support for arm64
Message-ID: <20220622171946.mc3cd375fy4fou3b@maple.lan>
References: <20220622154920.95075-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154920.95075-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 22, 2022 at 11:48:47PM +0800, Chen Zhongjin wrote:
> This series enables objtool to start doing stack validation and orc
> generation on arm64 kernel builds.
> 
> Based on Julien's previous work(1)(2), Now I have finished most of work
> for objtool enable on arm64. This series includes objtool part [1-13]
> and arm64 support part [14-33], the second part is to make objtool run
> correctly with no warning on arm64 so if necessary it can be taken apart
> as two series.
> 
> ORC generation feature is implemented but not used because we don't have
> an unwinder_orc on arm64, now it only be used to check whether objtool
> has correct validation.
> 
> This series depends on (https://lkml.org/lkml/2022/6/22/463)
> I moved some changes which work for all architectures to that series
> because this one becomes too big now.
> And it is rebased to tip/objtool/core branch.

What is the sha1 of the base?

With b4 and git am the patch series is derailing at patch 6 and I'm even
after a bit of fixup (had to use rediff) I'm still getting a cascade of
errors in later patches to decode.c .


Daniel.
