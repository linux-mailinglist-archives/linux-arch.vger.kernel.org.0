Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCE1882F0
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 13:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgCQMHm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 08:07:42 -0400
Received: from sonic316-53.consmr.mail.ne1.yahoo.com ([66.163.187.179]:35450
        "EHLO sonic316-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgCQMHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 08:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446861; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Pb8awjjoPLFbNPmlQcu+WfCpP1H8sAWwGgUp/Qx3Pcwhle2D+T+WaYyyUz3vhZc2sA8NWoswwQdZ/KESghs2zHwyJkIhXirXdAWNfFjUMk6Vp5O1n1ssbnqImAU4JjwDvjPE5MiKdDafzrksDX4SA4DXIy3uw5z0PxrkIBF4rhXMelpuym9jxC1A98OCGLpGKyrDFefSjQwR23hJ1LBEYAkVeqH1sTp6WjsgvuUGHHmG5uvgEDPMYyYwVJrLSDgjhr+D47MjFHu3UYl0qgRYHmrqCxT/2wEVkfOA8TgtmwXkxAQI+xiOEn1iZBc8Ai4JPRlE3U//zdU8HtFFhdooIw==
X-YMail-OSG: Ue05kJkVM1kESe4wgeLl5H8zREvh9Jzy0vP8VCQLM8PJGTeuE2buNJODfhWweCz
 1vmvxN8bsrpdUqTgf2mSrVOEBI.Ykkt2.MdNW7QLP647uWFlWjQeYgGe7NeWJiw5boZWccc74Xve
 Rn7DMObgN4KIVRULTFYteROsjYJkQpmeQWepDBY4fpCdiH30k9535EWUI0WxZlFJaoX3gbj_wO09
 OMMzjJ29Cl_6GZ5hldNpoyk4odcOtKvAR1uXCf.wcnhzNPfN1IVlbYWvvgoCKcHelF9z3CwgAER_
 2IkRnL0Q5gd.ZkBJq1H.5S_qpnqzS7_zOwVWyEoycZV5qZmk5ySbQbPNkWTPC1_cang8S_pkNwLa
 6cD8jXdjHmy0iBJjqgcPoVk5U733gBVcbKpYBfkUCW9lSdxlL7oq4egYb1uf1UqUk49YAI_MWlCm
 fdxr7PR_R0Y9vobxL361O.c18fFAcZrRHrbdIPQd1_aPKX9ZnQAfa0JqybNCXwPv5PbnH9N9S6o9
 9pAZ3LjofqtQ7oYl.cJW2feoDSc84dpceyLQcv.c9rtdNbLuG0thHf0c8bB_ll5yUuivz5YevWeg
 p7uV7BK9m8XQaJs9ZQWfLbxkMY11wurI2_1AQZJx4mLZoneoUxFdSMIYCrW6XXyzxozAv_MQCjN2
 .GxaWHIhPX9US1PCLq_Bo.o7drbVfXns0bg1nf18xZIwaaP7pTEwSERqmOGkhB8.k0tHolr_fBUO
 _0XWkHmkW9BQGNzLLNUlzM_WlwXZVfRohS7Y.NSj6oXoVzS4K7k1RShrbQHzY.bz5rOUmvf0LPcU
 PZRHdh1mKoTnp0no_jn1QLzvq_KdLL5yM0QzzD4zmzieLNpdoyi7.ivQHwqmyptSAx8AsISpMSq4
 2EljxAKn1U_HQ.3T7diRxivv0i7lXGdpoaf2SPZoqvOtiqAkNOOS.RUE9yQEMPypCVVZKocs1u2F
 cn0NDKNeQEP3NiFbhUcnyGLkBPerjrE_wGJCFUx8jOPPo6KJmqVVs.s.KF0o7UybWp7oMFyE1ZjE
 ioEq54V8SuHpDJg_VGg0RfHWCkNz4uBY1TVmk1OxfW0..lKWUr__xU.zLCsYiUtIrGSXXr9hwjPm
 Jy0EhQezMrKtXCcjbuFZlo8wBhTRz5vd52jWiPNuM1hIQ3xBdKifILYQfx7XzclZ1amj.0cBBd0p
 TeR.zjTgez6D1UpxAViLVXosPhE5.5yTsELYGSUfdQuDWIQqUqFi4IvtVtJvpXvE_JpsiCc68mfJ
 B9zjNbXYJAVi1fD0XysOM46aYeTgFM9diGwAee9dlxG.EQVigxo7L5xIva2GR9zacfaQbh8YtHvA
 VS76Cjecx2.KNJJSY3qTPpnKGKsc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:07:41 +0000
Date:   Tue, 17 Mar 2020 12:05:39 +0000 (UTC)
From:   Stephen Li <stenn8@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <1756093619.1826605.1584446739147@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1756093619.1826605.1584446739147.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
