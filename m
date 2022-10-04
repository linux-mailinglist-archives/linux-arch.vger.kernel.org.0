Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BE5F3E63
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJDIb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJDIbZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 04:31:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAB1DA46;
        Tue,  4 Oct 2022 01:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACA50B819A3;
        Tue,  4 Oct 2022 08:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F5DC433D6;
        Tue,  4 Oct 2022 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664872282;
        bh=hzwhDKjm0QN4l6nCj6New+H+VKqAoD+H5iDhuJMENCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6YMHUumqzfDa6S3sXTEnwAIrdkA5+K0lTI8Uh499EKNLhPfQgNghPc5QqYo/4JEE
         WPCK7jx7NMMFgq76werkS/sssRw4EG+FWiQ3Qai45tpwNVKBMnHyShvvbd/0wOPoMo
         d8hqknZy04Uf2AC5HB0vAApU3LGIjxJzm5W8seDTI7PZ07HbN1V4OgMN7oQaZnMgZ1
         yBGeQ766qhwYN4noaF8+3Dxmng+LArK0wWvvyz/AoyzeDCBvcXtiMt7O6VPekiLOD8
         LEHhwoo+ZaP/VfUZObUrgMzg5oI4nedG4Gvch7Ke4yOCB+d15DK+TKEksIc3E8gskU
         SPTa2D824VstA==
Date:   Tue, 4 Oct 2022 11:30:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com
Subject: Re: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Message-ID: <YzvvPxkP3SDsNXG+@kernel.org>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-30-rick.p.edgecombe@intel.com>
 <202210031525.78F3FA8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210031525.78F3FA8@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 03:28:47PM -0700, Kees Cook wrote:
> On Thu, Sep 29, 2022 at 03:29:26PM -0700, Rick Edgecombe wrote:
> > For the current shadow stack implementation, shadow stacks contents easily
> > be arbitrarily provisioned with data.
> 
> I can't parse this sentence.
> 
> > This property helps apps protect
> > themselves better, but also restricts any potential apps that may want to
> > do exotic things at the expense of a little security.
> 
> Is anything using this right now? Wouldn't thing be safer without WRSS?
> (Why can't we skip this patch?)

CRIU uses WRSS to restore the shadow stack contents.
 
> -- 
> Kees Cook

-- 
Sincerely yours,
Mike.
