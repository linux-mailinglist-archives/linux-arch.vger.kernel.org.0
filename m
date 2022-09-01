Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D80A5AA080
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiIAT4i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiIAT4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 15:56:38 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 12:56:35 PDT
Received: from cmx-torrgo002.bell.net (mta-tor-001.bell.net [209.71.212.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3780F7B
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 12:56:35 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.95.58.43]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 63086A7400A0F487
X-CM-Envelope: MS4xfCfUkCSMhjfT3pUPd5KByqJhFnFC3o194Wa5m4c8sWdnItDrEbsKwFJOEgxVhfctpbEntjxFEs5tdYEJo9xY36p8DU3UHO5PTW6RC9Z3DPZCp8r/mh7w
 cwDWiLO6w/qpCi9JBWBB7Q1maLfFipAGR4k3xcOa0Km9Z1hET68uPGdILO7EWorPT+mYp89WvTyOsP3w2ZJbZ+x6kx3zNOwFR14zoWKMoiKeBrFTatFk4Wgz
 x2w8KE685lX3yiJrWfJUQNG8ji09p9CD6ThChZl93zk/bmj2xmWvlE5Aw6MPpff9iO6LWy79HgCz3SSzXeiB5R2D45Wz+k3XFH1weoIbwNFfoNQW8gs4XUNy
 qONu2gRWq2gq+i8DshkEYZOfmxLTLSRJn5kMFUv9SuOt5nidpJe/wbCVjsQAWEMAOSb1W0pXvWvUJSJsJbibjxNJ7CmKtvyU4YMFk7i3umJQGmYsB3EJiarf
 zpA/UsPIpP0z+NPK
X-CM-Analysis: v=2.4 cv=XfXqcK15 c=1 sm=1 tr=0 ts=63110d8f
 a=oiJDitmlNOPgVxj52MZyFw==:117 a=oiJDitmlNOPgVxj52MZyFw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=X9396rpG3j-HrJrRoVkA:9 a=QEXdDO2ut3YA:10
 a=ATlVsGG5QSsA:10 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.95.58.43) by cmx-torrgo002.bell.net (5.8.807) (authenticated as dave.anglin@bell.net)
        id 63086A7400A0F487; Thu, 1 Sep 2022 15:52:47 -0400
Message-ID: <ce0a933b-5c82-8c27-c0b5-6a6b5d6cba0f@bell.net>
Date:   Thu, 1 Sep 2022 15:52:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] parisc: Use the generic IO helpers
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220901130654.177504-1-linus.walleij@linaro.org>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <20220901130654.177504-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-09-01 9:06 a.m., Linus Walleij wrote:
> + * These get provided from <asm-generic/iomap.h> sinc parisc does not
There's a typo in the above line.

I have build and booted a 64bit hppa kernel with this patch. So far, it seems okay.

Dave

-- 
John David Anglin  dave.anglin@bell.net

