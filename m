Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4496E2DC7
	for <lists+linux-arch@lfdr.de>; Sat, 15 Apr 2023 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDOAGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Apr 2023 20:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDOAGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Apr 2023 20:06:14 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA35FFA
        for <linux-arch@vger.kernel.org>; Fri, 14 Apr 2023 17:06:08 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j2-20020a170902da8200b001a055243657so10313123plx.19
        for <linux-arch@vger.kernel.org>; Fri, 14 Apr 2023 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681517167; x=1684109167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=27SavXWsOz2fFOmzF4nHb+ZNB/DHHSIE/WtD2FW1frE=;
        b=B6rYc8U7DGbKYNVYius6Nr1xFvfOgiOlW1pJgKmS1NVqaLzVhoraHcl1dTphDfkPeJ
         VC5xCv4i9COcEmzeOrD7NEAO9JflKku7ibWDLxlUZ7QUcBWfleeW76yKHqP1vsjsIBmS
         xOBlD3he/x1UVQg1EYc85ePh47AslSrznw1re6kKlcbBm07C50pD2jDiYbewN+qZWOeG
         EnLYD2OvDfZ5pDFaBqAkHKIhzuWoraoXAEemxILSM5u/iZ8A2ZqHiRuKc9YACWyOhPPn
         KTvKxPW2ojdNtXyipa/8Ht7nOBbNdsa/g4dO2xbQne+AS2SegO8N4SXpGOfagfMUjir5
         TCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681517167; x=1684109167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27SavXWsOz2fFOmzF4nHb+ZNB/DHHSIE/WtD2FW1frE=;
        b=Aj2xDZWdog3AJz8CljjuHMK8GxNNSv2PdVEJGkl9PLKoa+sKmxpZCP+uukn5+31qNx
         5veN4o+yz+sChB60bOvbcx0tpPKuzL0mgQSWa7WQ8yrjQTp14TbhWu4/dmBA7Qtl5Ylf
         J2t4exqS6aIiZEYvUbwa1vHj8Qohf3q+w8YlAd5l9tiVLTnXTAaWS2A8R+JRYYfreQeG
         4w5S8jMkJkjhNm6KpwHK23ZYUd4FN2pR6QWrSupUApUD+E12HxAkg+AKySdeexCgOyCV
         aix2zJ6A2D9U5XiJvowFH6drwgr5w9cJHSGJ3nQytzeU12SadQ7jaG2s98QtXB3wqjG7
         eFfw==
X-Gm-Message-State: AAQBX9cdt7NmNQqKbuBOn/lRiHxe5Za9xGfY6MD1hF9+b0IBWNyyKg0W
        LM9p/zMHN8PStDZ6j0F8Q+SLfyF9U7A=
X-Google-Smtp-Source: AKy350aWKg8kIKC0roeA72FaEe4HTb/wQtFuJp2chTATT/qvNt2jfzRorHJiQbnz3aOgwdrTNO7tZU5ONkg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9c3:b0:246:f8f7:f568 with SMTP id
 61-20020a17090a09c300b00246f8f7f568mr2063266pjo.0.1681517167336; Fri, 14 Apr
 2023 17:06:07 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:06:06 -0700
In-Reply-To: <ZDnhMQ2aoVYh6Qr2@google.com>
Mime-Version: 1.0
References: <ZDiCG/7OgDI0SwMR@google.com> <diqzbkjqnl6t.fsf@ackerleytng-cloudtop.c.googlers.com>
 <ZDnhMQ2aoVYh6Qr2@google.com>
Message-ID: <ZDnqbqykWot4+617@google.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     brauner@kernel.org, kirill.shutemov@linux.intel.com,
        chao.p.peng@linux.intel.com, hughd@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, michael.roth@amd.com,
        mhocko@suse.com, songmuchun@bytedance.com, pankaj.gupta@amd.com,
        linux-arch@vger.kernel.org, arnd@arndb.de, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, tabba@google.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 14, 2023, Sean Christopherson wrote:
> On Fri, Apr 14, 2023, Ackerley Tng wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > > 	if (WARN_ON_ONCE(file->private_data)) {
> > > 		err = -EEXIST;
> > > 		goto err_fd;
> > > 	}
> > 
> > Did you intend this as a check that the backing filesystem isn't using
> > the private_data field in the mapping?
> >
> > I think you meant file->f_mapping->private_data.
> 
> Ya, sounds right.  I should have added disclaimers that (a) I wrote this quite
> quickly and (b) it's compile tested only at this point.

FWIW, here's a very lightly tested version that doesn't explode on a basic selftest.

https://github.com/sean-jc/linux/tree/x86/upm_base_support
