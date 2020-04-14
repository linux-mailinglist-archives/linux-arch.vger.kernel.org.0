Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E871A7AA5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440053AbgDNMYy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440027AbgDNMYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 08:24:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2A1C061A0C;
        Tue, 14 Apr 2020 05:24:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so283088pgb.7;
        Tue, 14 Apr 2020 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Rb/je2Xt8A81/xIFagwzCqIYQq2/FJP34odIX+hqS1U=;
        b=UTY8X432PCL3xnyTGZfBuHl+0Bru8fmRiTRB3WNI37NEJ7KTMzoFLX2u03Uns6v3uq
         F/zxrSmFmkbGZUSIlNotinDSbHpNioo3BPibPY7Hq3u6abi0GiJHTsb44JDJWQtNBlCL
         vWKBwbGGopau7TdSdq4RHW5AYBcXX3ugO1gg/D9VurF5nr9DU9//Hc3tebF+AEXw7p23
         IjjZGeRtC+Y+5OKiYdSGb61HJWL626shxWK/InsgIDK/s0OVVuqFs8+Mx/Y7v6OWCPfA
         Y3tBiSH2mMbAHzyhVjdorRuJ5pwhgLWdYVX8ynemqDENLjjuLIWBi7zBSb9Y2MMRVhXc
         niCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Rb/je2Xt8A81/xIFagwzCqIYQq2/FJP34odIX+hqS1U=;
        b=dPUGhstpUOZVJxukD/4L8BjrZIOhm91rFQJWbTEkLwBd3aDug+BBijIQbJAueOfpE+
         y4B73cr4guPWa6JqPP4DzKo0htrHKv6H7IeOj/diHLr7W4H8WBbAGv1tDdg8qvwW0+lB
         YBiaLcHOH1hXCzvX8d2/mLl9UQjBUQUsXGotoV7wNwy/0CUyeu1tiUovNBgDcxcGQWCd
         hXHob9A/dP2MmsPF1DY1EWv1+TTMnQLaKNqCuDosjImOARM0PtL50XN5N7ne2H03p76p
         D4MAfWB07odS8aoTeBGTQJAIMBTUV7G4qkUviBTmokWAqmzlk4ylJ7mjukVWQfmUt48P
         rACw==
X-Gm-Message-State: AGi0PuZWZL8uTymah2emiEgQUmM1hstb/bhoawHgtlR63cfzwmwTJ8CD
        qJafZTFNXl0nR8ewBoYi42Y=
X-Google-Smtp-Source: APiQypKChJa2JAz01cF35C6aERv1vm8eZC5rnffnL1LIrhvrzG/AI0EVc0p0VH0u8Wat3QrbLfmOYQ==
X-Received: by 2002:a62:5e86:: with SMTP id s128mr23700777pfb.157.1586867092854;
        Tue, 14 Apr 2020 05:24:52 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id p19sm1389150pfn.19.2020.04.14.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:24:52 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:23:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/4] huge vmalloc mappings
To:     David Rientjes <rientjes@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <alpine.DEB.2.21.2004131727150.260270@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2004131727150.260270@chino.kir.corp.google.com>
MIME-Version: 1.0
Message-Id: <1586866432.g0r7udmtjr.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from David Rientjes's message of April 14, 2020 10:27 am:
> On Mon, 13 Apr 2020, Nicholas Piggin wrote:
>=20
>> We can get a significant win with larger mappings for some of the big
>> global hashes.
>>=20
>> Since RFC, relevant architectures have added p?d_leaf accessors so no
>> real arch changes required, and I changed it not to allocate huge
>> mappings for modules and a bunch of other fixes.
>>=20
>=20
> Hi Nicholas,
>=20
> Any performance numbers to share besides the git diff in the last patch i=
n=20
> the series?  I'm wondering if anything from mmtests or lkp-tests makes=20
> sense to try?

Hey, no I don't have any other tests I've run. Some of the networking
hashes do make use of it as well though, and might see a few % in
the right kind of workload. There's probably a bunch of other stuff
where it could help a little bit, looking through the tree, I just don't
have anything specific.

Thanks,
Nick
