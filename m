Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88612653C7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfGKJ1v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 05:27:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37234 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJ1v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 05:27:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id g15so2653760pgi.4;
        Thu, 11 Jul 2019 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=ctjQwgCLlp604HpVeqlyCBpmRi6PoJDKRevkqL/NNWA=;
        b=XW74OVagqyugV3/wP3THCRvzAueu17tkpao+yo5IHjM8lpQKb6048H3Ny2zPiMlaBe
         eWhLpF+K9KQHEB6wbz91Dz2IO+zyXpsqcPKHP8E66kSa23MHmWz3BI2wuZDY/GlcAlX4
         9gip+KCwm1zKSnAXDjwQ877ARE5KD+Pxzj5PsfoCR+q/o0Svm/zLZOPTOyDxJySzf2+s
         DvfIPszRwZRSYyF/1o5IZqMVya9UQ/720bkO3YthabEBSWqkyw/vwZ9nxtWAWlY632XS
         BKAux4fqS5G4Wz32aM2yJP+pKtMljHicKmK/1r0jMBgrbxwmDP1BpKTgVQhcZmCj0dwO
         R3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=ctjQwgCLlp604HpVeqlyCBpmRi6PoJDKRevkqL/NNWA=;
        b=VqMH3AX07vcfqmovCM00urOuvF3cGk0VXffmvGRjv4DfrOXvfjE4F8Tpr4jJOkV2a0
         QkPfnlIj5KFGiFsF9c81bh7C85RzKI/ALlLOiR/pACfk5zqEOj0v/VAxl0zBzsL97SKK
         +1NA1F6kLJ1BBTPP/3AD3BhZCeplTuJh2R+VQ/dMlOoOCTZDklbwe6EotS6GAHhdr5bs
         VBeszSWeRsfVa8eENDWX1OO0XWXJg5UUk6Llevqn4hDZzmwdZdrJJpNzavvtgHLaWnXr
         0QE4XnYjOh3/QRrHXHQQSFwnhAQfoOkwytroOqMMb4f1XyLL8vw1CsdBdKgMNqaBBeKV
         lDqw==
X-Gm-Message-State: APjAAAX1R9KUYHWM5zNSIF4/vpEQD59hw2EK/7jJD0STn8fC9oCcp+Ab
        xmkwMZyQqHjWULye5o+CfSzJdpBG
X-Google-Smtp-Source: APXvYqzBE9aU+/1BWb2TunJAkuLc1lAKBCpOQTAA/+hp8NBdlzCDfV9tpMXfluq3s3+NBBp7T2SqaQ==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr3712815pjc.63.1562837270504;
        Thu, 11 Jul 2019 02:27:50 -0700 (PDT)
Received: from localhost (193-116-118-149.tpgi.com.au. [193.116.118.149])
        by smtp.gmail.com with ESMTPSA id q69sm6572107pjb.0.2019.07.11.02.27.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 02:27:49 -0700 (PDT)
Date:   Thu, 11 Jul 2019 19:24:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
To:     Christopher Lameter <cl@linux.com>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
References: <20190711030339.20892-1-npiggin@gmail.com>
        <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
In-Reply-To: <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1562835751.mpbmrr7rdc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christopher Lameter's on July 11, 2019 5:54 pm:
> On Thu, 11 Jul 2019, Nicholas Piggin wrote:
>=20
>> Remove page table allocator "quicklists". These have been around for a
>> long time, but have not got much traction in the last decade and are
>> only used on ia64 and sh architectures.
>=20
> I also think its good to remove this code. Note sure though if IA64
> may still have a need of it. But then its not clear that the IA64 arch is
> still in use. Is it still maintained?

It should still work (as well as other archs). Does it have any
particular need for page table allocation speed compared to others?

I actually think it's more benefit for ia64 and sh than anything.
For other arches it's no big deal, and generic code just sprinkles
some poorly named function around the place with no real way to
know where it should go or test it. Then not to mention its
interaction with other memory queues.

>> Also it might be better to instead make more general improvements to
>> page allocator if this is still so slow.
>=20
> Well yes many have thought so and made attempts to improve the situation
> which generally have failed. But even the fast path of the page allocator
> seems to bloat more and more. The situation is deteriorating instead of
> getting better and as a result lots of subsystems create their own caches
> to avoid the page allocator.

Yeah, to some degree I agree. And if someone would test it on a modern
CPU and workload that would be cool.

But for example in most workloads you would expect the rate of page
allocation and freeing for processes to be on the same order of=20
magnitude at the low end, up to 2 orders of magnitude higher than
page tables that map them. Not true perhaps for very large shared
mmaps, but all in all IMO it's not clear this is a good tradeoff, or
it's a good idea to proliferate these little queues around the place.

Anyway that's just handwaving from me, but I'm not against the code
being resurrected and added to the more important archs if it shows
good gains on something relevant.

Thanks,
Nick
=
