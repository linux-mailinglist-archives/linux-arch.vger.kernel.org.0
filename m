Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFADFD207
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2019 01:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOAi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 19:38:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33383 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOAi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 19:38:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so8833043wmb.0;
        Thu, 14 Nov 2019 16:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V+xyAyokSVdG2YJZBQsiL4UYdt3E6o24h3s6g0fTDHQ=;
        b=alMS8AvtcH2tnUO26K5nS7zSK+98v4P5mFBkv5HzrpQRFZdrUnC08/d/o+dCvZF771
         PIxw8+RRGzhcv5JtqMhmNFK00a7GHIvyNyHTmJs084SQkIENknsGDyc4PuV1ARIIeqSB
         ztUx3sBVVVX/MJScjB/cJQknV4L1rNX8tWcFY7qb3MpX0EUOpFtT7YCkp5i9Rr9iZFbc
         8npg3kUuCrQ7lVnCaivW3205Pj2eKwC/fXKO6Rd427N2IIPs1BJBVh327D4JM1GG/RqY
         ueb40XzyXltLWlprmaL0Eun06GDo1jZ3JWyORxThL/yCXFXzPoAUqbgzPF8FlCHAeLYF
         v9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V+xyAyokSVdG2YJZBQsiL4UYdt3E6o24h3s6g0fTDHQ=;
        b=jTJWD5dyOzO2DErh8K4cAYUyf53XZjqieqE0KjJ6U0ST9asHLjhC6SYLLIJA7fhdDC
         DF3759Fo9EWYE0WnnNVQZ0iq/jzEeROyPwKLBWa7Achg6s5jjCcZWAFgN4VHlDcUyY+J
         ffIQjIWIs+o0MXLQ5XNzTeQzppWeIKFrMm1jQxXHnKs9EJR7yxnrLC8FEueDUA6Fn9TZ
         7sqoEhcVQA9kMqxr2k9Z97lOVCdDg8dLu571ddzbtf0OrTr4f/G3XWemv4C/oEE2DF+5
         BXdQK8g4ycTpOc79tVq8SMkR99b/ykrf7PRrAj5aCqyZACFiomXJ4oZmZ69H5cp+02De
         LITw==
X-Gm-Message-State: APjAAAW57VIqgpBdYFts1w4Zu7c/X26h0DTo+1XFswrA9NbPjCCNA+Nj
        4dsyV3hJuyShS+5wtk5vvJU=
X-Google-Smtp-Source: APXvYqw+jrTZ3N3Sm7eZpuhockFOKaDrAq0PEkEBLyklk7eKmoF21L840DTBnyz29dOFz0ycSxS9pA==
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr10714765wmb.136.1573778303928;
        Thu, 14 Nov 2019 16:38:23 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40e1:9900:b41c:b7ad:6b56:89fb])
        by smtp.gmail.com with ESMTPSA id g133sm7856389wme.42.2019.11.14.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 16:38:23 -0800 (PST)
Date:   Fri, 15 Nov 2019 01:38:21 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>, linux-sparse@vger.kernel.org,
        kbuild-all@lists.01.org, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20191115003821.raskzlj7hscz7vax@ltop.local>
References: <20191107174622.61718-4-alex.kogan@oracle.com>
 <201911110540.8p3UoQAR%lkp@intel.com>
 <58623E4A-973B-46CC-8FA8-29E68DB5EFF4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58623E4A-973B-46CC-8FA8-29E68DB5EFF4@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 14, 2019 at 03:57:34PM -0500, Alex Kogan wrote:
> + linux-sparse mailing list
> 
> It seems like a bug in the way sparse handles “pure” functions that return
> a pointer.

Yes, it's a bug in sparse.
 
> The warnings can be eliminated by adding an explicit cast, e.g.:
> 
> 	node = (struct mcs_spinlock *)grab_mcs_node(node, idx);
> 
> but this seems wrong (unnecessary) to me.

Indeed, it would be wrong.

Thanks for analyzing and reporting this,
-- Luc 
